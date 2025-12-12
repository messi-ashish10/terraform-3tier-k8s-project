resource "aws_key_pair" "project_key" {
  key_name   = "project-3tier-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "project-3tier-key"
  }
}