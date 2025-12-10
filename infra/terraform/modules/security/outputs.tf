output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "Security group ID for app/backend tier"
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "Security group ID for database tier"
  value       = aws_security_group.db.id
}

output "bastion_sg_id" {
  description = "Security group ID for bastion"
  value       = var.enable_bastion_sg ? aws_security_group.bastion[0].id : null
}