#Locals
locals{
    name_prefix = "${var.project}-${var.environment}"

    common_tags = merge(
        var.tags,{
            project = var.project
            Environment = var.environment
            ManagedBy = "Terraform"
        }
    )

    nat_gateway_count = var.enable_nat_gateway ? (
        var.single_nat_gateway ? 1 : length(var.azs)
    ) : 0
}

#VPC
resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = merge(
        local.common_tags,{
            Name = "${local.name_prefix}-vpc"
        }
    )
}

#Internet Gateway
resource "aws_internet_gateway" "this"{
    vpc_id = aws_vpc.this.id

    tags = merge(
        local.common_tags,{
            Name = "${local.name_prefix}-igw"
        }
    )
}

#Public subnets
resource "aws_subnet" "public"{
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.this.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = merge(
        local.common_tags,{
            Name = "${local.name_prefix}-public-${count.index + 1}"
            Tier = "Public"
        }
    )
}

#Private subnets
resource "aws_subnet" "private"{
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    
    tags = merge(
        local.common_tags,{
            Name = "${local.name_prefix}-private-${count.index + 1}"
            Tier = "private"
        }
    )
}

#Nat gateway
resource "aws_eip" "nat" {
  count      = local.nat_gateway_count
  domain     = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-eip-${count.index + 1}"
    }
  )
}

resource "aws_nat_gateway" "this" {
  count         = local.nat_gateway_count
  allocation_id = aws_eip.nat[count.index].id

  # If single_nat_gateway = true, always use first public subnet
  subnet_id = aws_subnet.public[
    var.single_nat_gateway ? 0 : count.index
  ].id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.this]
}

#Route Tables
resource "aws_route_table" "public"{
    vpc_id = aws_vpc.this.id
    
    tags = merge(
        local.common_tags,{
            Name = "${local.name_prefix}-public-rt"
            Tier = "public"
        }
    )
}

#default route for internet via IGW 
resource "aws_route" "public_internet_route"{
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
}

# Private Route Table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-rt"
      Tier = "private"
    }
  )
}

# Default route for private subnets via NAT
resource "aws_route" "private_nat_route" {
  count                  = local.nat_gateway_count > 0 ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

#Associate all public subnets with Public rt
resource "aws_route_table_association" "public"{
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

#Associate all private subnets with Private rt
resource "aws_route_table_association" "private"{
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}