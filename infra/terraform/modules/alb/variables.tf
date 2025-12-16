variable "vpc_id"{
    description = "VPC ID where the ALB will be created"
    type = string
}

variable "public_subnet_ids"{
    description = "Public subnet IDs for the ALB"
    type = list(string)
}

variable "app_port"{
    description = "Port on which the application listens"
    type = number
}

variable "health_check_path"{
    description = "Health check path for the target group"
    type = string
    default = "/health"
}

variable "tags"{
    description = "Common tags"
    type = map(string)
    default = {}
}