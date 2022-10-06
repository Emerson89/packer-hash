output "public_dns" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.ec2.public_dns
}

output "tags" {
  description = "List of tags assigned to the instances, if applicable"
  value       = module.ec2.tags_all
}

output "private_key_pem" {
  description = "The private IP address assigned to the instance."
  value       = module.ec2.private_key_pem
  sensitive = true
}