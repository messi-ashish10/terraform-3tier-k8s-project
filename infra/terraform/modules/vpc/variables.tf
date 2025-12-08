variable "cidr_block"{
    description = "CIDR block for the VPC"
    type = string
}

variable "vpc_name"{
    description = "Name tag for the VPC"
    type = string
}

variable "environment"{
    description = "Environment tag"
    type = string
    default = "dev"
}