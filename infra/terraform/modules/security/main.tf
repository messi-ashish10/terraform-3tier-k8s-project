#Locals
locals {
  name_prefix = "${var.project}-${var.environment}"

  common_tags = merge(
    var.tags, {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
      Component   = "security"
    }
  )
}

#ALB Security Group (public-facing)
resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for ALB (public-facing)"
  vpc_id      = var.vpc_id

  #Allow HTTP from anywhere
  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = var.alb_http_port
    to_port     = var.alb_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow HTTPS from anywhere
  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = var.alb_https_port
    to_port     = var.alb_https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound to anywhere (ALB can reach targets/health checks)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags, {
      Name = "${local.name_prefix}-alb-sg"
      Tier = "public"
      Role = "alb"
    }
  )
}

#App/Backend Security Group (Private)
resource "aws_security_group" "app" {
  name        = "${local.name_prefix}-app-sg"
  description = "Security group for application/backend tier"
  vpc_id      = var.vpc_id

  #Only allow traffic from ALB SG on app port
  ingress {
    description     = "App port from ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  #Optional: allow SSH from bastion SG
  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = var.enable_bastion_sg ? [aws_security_group.bastion[0].id] : []
  }

  #Outbound: app can reach DB and internet (via NAT)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags, {
      Name = "${local.name_prefix}-app-sg"
      Tier = "private"
      Role = "app"
    }
  )
}

#Database Security Group (private, isolated)
resource "aws_security_group" "db" {
  name        = "${local.name_prefix}-db-sg"
  description = "Security group for database tier"
  vpc_id      = var.vpc_id

  #Only allow DB port from APP SG
  ingress {
    description     = "DB port from app tier"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  #Outbound:
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags, {
      Name = "${local.name_prefix}-db-sg"
      Tier = "private"
      Role = "db"
    }
  )
}

#Bastion/SSH Security Group
resource "aws_security_group" "bastion" {
  count       = var.enable_bastion_sg ? 1 : 0
  name        = "${local.name_prefix}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from allowed CIDRS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description = "Allow all outbound traffic from bastion"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags, {
      Name = "${local.name_prefix}-bastion-sg"
      Tier = "public"
      Role = "bastion"
    }
  )
}