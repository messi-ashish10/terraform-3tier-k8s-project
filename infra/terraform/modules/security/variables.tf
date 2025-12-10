variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "tags" {
  description = "Base tags to apply to all security groups"
  type        = map(string)
  default     = {}
}

variable "alb_http_port" {
  description = "HTTP port for ALB"
  type        = number
  default     = 80
}

variable "alb_https_port" {
  description = "HTTPS port for ALB"
  type        = number
  default     = 443
}

variable "app_port" {
  description = "Application/backend port"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 27017
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH into bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_bastion_sg" {
  description = "Whether to create a bastion SSH security group"
  type        = bool
  default     = true
}