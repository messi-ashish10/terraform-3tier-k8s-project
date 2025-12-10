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
  enable_nat_gateway = false
  single_nat_gateway = true

  tags = local.common_tags
}

module "security"{
  source = "./modules/security"
  project = local.project
  environment = local.environment
  vpc_id = module.vpc.vpc_id

  tags = local.common_tags

  #ports
  alb_http_port = 80
  alb_https_port = 443
  app_port = 8080
  db_port = 27017

  #ssh_allowed_cidrs = ["YOUR_IP/32"]
  enable_bastion_sg = true
}