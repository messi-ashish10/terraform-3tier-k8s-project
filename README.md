# Terraform-3tier-k8s-project
A complete 3-tier application deployed using Terraform, Docker, and Kubernetes. This project builds the infrastructure, containerizes the app, and deploys it on a scalable Kubernetes environment.

# Prerequisites

Before working on this project, I set up the essential tools and configurations in my local environment.  
Everything here was installed on **Windows with WSL2 (Ubuntu 22.04)**, but the same tools can be used on Linux or macOS as well.

- **WSL2 (Ubuntu)** set up as the development environment  
- **Docker**, **Kubectl**, **Minikube**, and **Helm** installed on Ubuntu  
- **Terraform** installed and authenticated with AWS using `aws configure`  
- Valid **AWS IAM user or IAM role** with programmatic access  
- **Git** installed with SSH access configured for GitHub  
- Project structure already initialized (`app/`, `docker/`, `infra/`, `kubernetes/`, `cicd/`, etc.)

Before continuing, please follow the  
👉 **[Installation Guide](./docs/installation)**  
for detailed setup instructions.
---

