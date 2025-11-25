# 🔧 Terraform Installation & Setup Guide

This file contains all the steps I followed to install Terraform on WSL and configure it using my AWS AssumeRole setup.

---

# 1. Install Terraform on WSL (Ubuntu)

## Step 1: Install required packages
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

## Step 2: Add HashiCorp GPG key
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

## Step 3: Add HashiCorp repository
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

## Step 4: Update and install Terraform
```bash
sudo apt update
sudo apt install terraform -y
```

## Step 5: Verify installation
```bash
terraform version
```

---

# 2. Configure Terraform With AWS AssumeRole

Terraform will use the AWS profile you created earlier (`terraform-admin`).

Check your AWS profile:
```bash
aws sts get-caller-identity
```

If it shows your **IAM Role ARN**, you are ready to use Terraform.

---

# 3. Initialize Terraform in Your Project

Navigate to your Infra folder:

```bash
cd infra
```

## Step 1: Initialize Terraform
```bash
terraform init
```

## Step 2: Validate configuration
```bash
terraform validate
```

## Step 3: Preview AWS resources
```bash
terraform plan
```

---
