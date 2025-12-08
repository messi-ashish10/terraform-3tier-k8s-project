terraform{
    backend "s3"{
        bucket = "project-3tier-state-bucket"
        key = "project-3tier/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-lock-table"
        encrypt = true
    }
}