output "aws_account_id" {
  description = "AWS account ID derived from the active credentials."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region_name" {
  description = "Region currently targeted by this Terraform configuration."
  value       = data.aws_region.current.name
}

output "default_tags" {
  description = "Tag map applied to all managed resources."
  value       = local.default_tags
}
