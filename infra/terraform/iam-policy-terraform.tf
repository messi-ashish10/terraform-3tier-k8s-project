resource "aws_iam_policy" "terraform_iam_policy" {
  name        = "Terraform_IAM-Execution-Policy"
  description = "Permissions for Terraform to manage IAM, EC2, and related resoucre"

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "iam:CreateRole",
            "iam:DeleteRole",
            "iam:GetRole",
            "iam:ListRoles",
            "iam:AttachRolePolicy",
            "iam:DetachRolePolicy",
            "iam:CreateInstanceProfile",
            "iam:DeleteInstanceProfile",
            "iam:AddRoleToInstanceProfile",
            "iam:RemoveRoleFromInstanceProfile",
            "iam:PassRole"
          ]
          Resource = "*"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "terraform_iam_attach" {
  role       = data.aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.terraform_iam_policy.arn
}
