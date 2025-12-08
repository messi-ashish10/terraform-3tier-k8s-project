terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = "default"

  assume_role {
    role_arn     = "arn:aws:iam::495804826271:role/TerraformExecutionRole"
    session_name = "terraform-session"
  }
}
