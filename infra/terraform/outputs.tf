output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "app_instance_id" {
  value = module.app_ec2.instance_id
}

output "frontend_bucket" {
  value = module.frontend.bucket_name
}

output "frontend_cloudfront_url" {
  value = module.frontend.cloudfront_url
}