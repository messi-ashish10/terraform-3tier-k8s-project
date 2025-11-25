# terraform-3tier-k8s-project
A complete 3-tier application deployed using Terraform, Docker, and Kubernetes. This project builds the infrastructure, containerizes the app, and deploys it on a scalable Kubernetes environment.

# 🔧 Prerequisites

Before working on this project, I set up the essential tools and configurations in my local environment.  
Everything here was installed on **Windows with WSL2 (Ubuntu 22.04)**, but the same tools can be used on Linux or macOS as well.

---

## 1. System Setup
- Windows 10/11  
- WSL2 enabled  
- Ubuntu 22.04 (inside WSL)

---

## 2. Tools I Installed
These tools are required for development and testing.  
All of them are already installed and working in my setup.

- **Docker** – for building and running containers  
- **kubectl** – Kubernetes command-line tool  
- **Minikube** – to run a local Kubernetes cluster  
- **Helm** – Kubernetes package manager

---

## 3. AWS Configuration
To connect Terraform with AWS, I completed these steps:

- Installed and configured **AWS CLI v2**  
- Set up an **IAM User** with Access Key and Secret Key  
- Created a dedicated **IAM Role** for Terraform  
  - The role includes `sts:AssumeRole`  
  - The trust policy allows my IAM user to assume it  
- Added a new AWS CLI profile that assumes this role  
  (example: `terraform-admin`)

The role assumption was tested using:

```bash
aws sts get-caller-identity

