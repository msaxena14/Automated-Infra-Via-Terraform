variable "aws_region" {
  description = "AWS region for IAM resources"
  type        = string
  default     = "us-east-1"
}

variable "databricks_host" {
  description = "Databricks workspace URL"
  type        = string
}

variable "databricks_token" {
  description = "Databricks personal access token"
  type        = string
  sensitive   = true
}

variable "cluster_user_email" {
  description = "Email address granted single-user access to the cluster"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name the IAM role gets full s3:* access to"
  type        = string
}

variable "cluster_autotermination_minutes" {
  description = "Minutes of inactivity before cluster auto-terminates"
  type        = number
  default     = 20
}

variable "databricks_cross_account_role_name" {
  description = "Name of the Databricks cross-account IAM role in this AWS account"
  type        = string
}

variable "databricks_cloud_storage_role_arn" {
  description = "ARN of the Databricks cloud-storage IAM role used by Unity Catalog serverless compute"
  type        = string
}

variable "databricks_cloud_storage_external_id" {
  description = "STS external ID for the cloud-storage role trust policy"
  type        = string
  sensitive   = true
}

variable "databricks_serverless_external_id" {
  description = "STS external ID for the Databricks serverless role (format: databricks-serverless-<workspace-id>)"
  type        = string
  sensitive   = true
}

variable "vortex_agent_external_location" {
  description = "Name of the pre-existing Unity Catalog External Location to grant READ_FILES/WRITE_FILES on (must already exist in the metastore)"
  type        = string
  default     = "vortex_agent"
}
