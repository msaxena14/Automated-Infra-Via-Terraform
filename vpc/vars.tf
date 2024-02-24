variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"  # You can change the default to the desired region
}

variable "vpc_name" {
  description = "VPC Provisioned via terraform"
  type        = string
  default     = "Demo-Terraform"
}

variable "environment" {
  description = "Environment in which the resources will be created"
  type        = string
  default     = "dev"
}