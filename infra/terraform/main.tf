module "vpc" {
  source      = "./modules/vpc"
  project     = local.project
  environment = local.environment

  vpc_cidr = "10.0.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b",
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24",
  ]

  #Learning
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.common_tags
}

module "security" {
  source      = "./modules/security"
  project     = local.project
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  tags = local.common_tags

  #ports
  alb_http_port  = 80
  alb_https_port = 443
  app_port       = 8080
  db_port        = 27017

  #ssh_allowed_cidrs = ["YOUR_IP/32"]
  enable_bastion_sg = true
}

module "bastion" {
  source               = "./modules/ec2"
  name                 = "bastion-host"
  ami_id               = data.aws_ami.amazon_linux.id
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_ids   = [module.security.bastion_sg_id]
  key_name             = aws_key_pair.project_key.key_name
  associate_public_ip  = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Environment = "dev"
    Role        = "bastion"
  }
}

module "app_ec2" {
  source               = "./modules/ec2"
  name                 = "app-server"
  ami_id               = data.aws_ami.amazon_linux.id
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.private_subnet_ids[0]
  security_group_ids   = [module.security.app_sg_id]
  associate_public_ip  = false
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  key_name             = null
  user_data_path       = "${path.module}/user_data/docker.sh"
  tags = {
    Name        = "app-server"
    Environment = var.environment
    Project     = "project-3tier"
  }
}

#Calling Load Balancer
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  app_port          = 3000

  tags = {
    Project = "project-3tier"
    Env     = "dev"
  }
}

#Attach EC2 with ALB target group
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.app_ec2.instance_id
  port             = 8080
}