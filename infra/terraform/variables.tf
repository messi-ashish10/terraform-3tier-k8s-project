variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name dev"
  type        = string
  default     = "dev"
}

variable "public_key_path"{
    description = "Path to public SSH key"
    type = string
}