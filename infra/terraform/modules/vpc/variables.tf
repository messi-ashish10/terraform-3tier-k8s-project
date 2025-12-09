variable "project"{
    description = "Project name prefix"
    type = string
}

variable "environment"{
    description = "Environment name"
    type = string
}

variable "vpc_cidr"{
    description = "CIDR block for the VPC"
    type = string
}

variable "azs"{
    description = "List of availability zones to use"
    type = list(string)
}

variable "enable_nat_gateway"{
    description = "Wheter to create NAT Gateway(s) for private subnets"
    type = bool
    default = false
}

variable "single_nat_gateway"{
    description = "If true, only one NAT gateway is created"
    type = bool
    default = true
}

variable "tags"{
    description = "Base tags to apply to all resources"
    type = map(string)
    default = {}
}


#Validation
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.azs)
    error_message = "public_subnet_cidrs must match number of AZs."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.azs)
    error_message = "private_subnet_cidrs must match number of AZs."
  }
}