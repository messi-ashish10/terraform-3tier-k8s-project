# ☁️ AWS Setup Guide (Account, IAM User, IAM Role, AWS CLI)

This document includes everything I did to set up AWS from the beginning:  
creating an AWS account, creating an IAM user, creating an IAM role, and configuring AWS CLI in WSL.

---

# 1. Create AWS Account

1. Go to https://aws.amazon.com/
2. Click **Create an AWS Account**
3. Enter:
   - Email
   - Password
   - Account name
4. Choose **Personal Account**
5. Enter your contact information
6. Add your payment card (required by AWS)
7. Complete identity verification
8. Sign in to the AWS Console

Your account is now active.

---

# 2. Create an IAM User (For CLI Access)

## Step 1: Open IAM Service
- Go to AWS Console
- Search for **IAM**
- Open **IAM dashboard**

## Step 2: Create User
- Click **Users → Create User**
- Enter a username (example: `terraform-user`)

## Step 3: Access Type
Select:
- **Access Key - Programmatic Access**

## Step 4: Permissions
Choose:
- **Attach existing policies directly**

Recommended:
- `AdministratorAccess` (for learning/practice)  

## Step 5: Finish
- Download the **Access Key ID** and **Secret Access Key**
- Save them securely — you will need these in WSL

Your IAM user is ready.

---

# 3. Install AWS CLI in WSL

Download the installer:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Unzip:

```bash
unzip awscliv2.zip
```

Install:

```bash
sudo ./aws/install
```

Verify:

```bash
aws --version
```

---

# 4. Configure AWS CLI (Base Profile)

```bash
aws configure --profile default
```

Enter:
- Access Key  
- Secret Key  
- Region (example: `ca-central-1`)  
- Output: `json`

This profile uses your **IAM User**.

---

# 5. Create an IAM Role for Terraform

We create a separate role so Terraform can assume it instead of using the user directly.

## Step 1: Go to IAM → Roles → Create Role

Choose:
- **Trusted entity type: AWS Account**
- Select **My AWS Account**

Enable:
- **Require MFA?** (optional)
- **Require external ID?** (no)

Click **Next**

## Step 2: Permissions for the Role

Attach:
- `AdministratorAccess` (for practice)

Click **Next**

## Step 3: Role Name

Example:
```
terraform-admin
```

Finish creating the role.

---

# 6. Update Role Trust Policy (Allow IAM User)

Open the newly created role → **Trust relationships → Edit policy**

Use this JSON:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<ACCOUNT_ID>:user/<IAM_USER_NAME>"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

Replace:
- `<ACCOUNT_ID>`
- `<IAM_USER_NAME>`

Save it.

This allows your user to assume this role.

---

# 7. Add AWS CLI Profile for the Role

Edit:

```
~/.aws/config
```

Add:

```ini
[profile terraform-admin]
role_arn = arn:aws:iam::<ACCOUNT_ID>:role/terraform-admin
source_profile = default
region = ca-central-1
```

Save the file.

---

# 8. Test Role Assumption

```bash
export AWS_PROFILE=terraform-admin
aws sts get-caller-identity
```

You should see the **role ARN**, not the user ARN.

If yes → everything is working correctly.

---


This setup follows best practices for DevOps learning.

