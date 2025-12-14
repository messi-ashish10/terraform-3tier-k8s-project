variable "name"{
    description = "Name prefix for EC2 instance"
    type = string
}

variable "ami_id"{
    description = "AMI ID for EC2"
    type = string
}

variable "instance_type"{
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}

variable "subnet_id"{
    description = "subnet ID where EC2 will be launched"
    type = string
}

variable "security_group_ids"{
    description = "List of security group IDs"
    type = list(string)
}

variable "key_name"{
    description = "SSH key pair name"
    type = string
}

variable "associate_public_ip"{
    description = "Associate public IP or not"
    type = bool
    default = false
}

variable "iam_instance_profile"{
    description = "IAM instance profile name"
    type = string
    default = null
}

variable "tags"{
    description = "Tags for EC2"
    type = map(string)
    default = {}
}

variable "user_data_path"{
    description = "Path to user_data script"
    type = string
    default = null
}