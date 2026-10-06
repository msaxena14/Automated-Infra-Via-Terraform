output "cluster_id" {
  description = "Databricks cluster ID"
  value       = module.databricks.cluster_id
}

output "instance_profile_arn" {
  description = "AWS instance profile ARN"
  value       = module.databricks.instance_profile_arn
}

output "iam_role_arn" {
  description = "IAM role ARN for S3 access"
  value       = module.databricks.iam_role_arn
}

output "volume_full_name" {
  description = "Full Unity Catalog path: fhir.default.libs"
  value       = module.databricks.volume_full_name
}
