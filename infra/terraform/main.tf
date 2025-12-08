module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  vpc_name    = "project-3tier-vpc"
  environment = var.environment
}