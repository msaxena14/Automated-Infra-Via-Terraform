# =============================================================================
# Databricks environment — provisions cluster, Unity Catalog, and S3 IAM role.
#
# Prerequisites:
#   - Databricks workspace already exists
#   - Metastore already created and attached to the workspace
#   - AWS credentials configured with iam:* permissions
#
# Run:
#   terraform init
#   terraform plan
#   terraform apply
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "fhir-databricks"
      ManagedBy = "terraform"
    }
  }
}

provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

module "databricks" {
  source = "../../modules/databricks"

  aws_region                           = var.aws_region
  cluster_user_email                   = var.cluster_user_email
  s3_bucket_name                       = var.s3_bucket_name
  cluster_autotermination_minutes      = var.cluster_autotermination_minutes
  databricks_cross_account_role_name   = var.databricks_cross_account_role_name
  databricks_cloud_storage_role_arn    = var.databricks_cloud_storage_role_arn
  databricks_cloud_storage_external_id = var.databricks_cloud_storage_external_id
  databricks_serverless_external_id    = var.databricks_serverless_external_id
  vortex_agent_external_location       = "${var.s3_bucket_name}/fhir"
}
