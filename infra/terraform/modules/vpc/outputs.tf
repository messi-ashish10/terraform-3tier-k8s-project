output "vpc_id"{
    description = "ID of the created VPC"
    value = aws_vpc.this.id
}

output "public_subnet_ids"{
    description = "IDs of private subnets"
    value = aws_subnet.public[*].id
}

output "private_subnet_ids"{
    description = "IDs of private subnets"
    value = aws_subnet.private[*].id
}

output "public_route_table_id"{
    description = "ID of the public route table"
    value = aws_route_table.public.id
}

output "private_route_table_id"{
    description = "ID of the private route table"
    value = aws_route_table.public.id
}

output "nat_gatway_ids"{
    description = "IDs of NAT Gateways"
    value = aws_nat_gateway.this[*].id
}

output "igw_id"{
    description = "ID of the Internet Gateway"
    value = aws_internet_gateway.this.id
}