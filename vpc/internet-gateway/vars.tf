variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "igw_id" {
  description = "IGW ID"
  type = string
}

variable "project" {
  description = "VPC Provisioned via terraform"
  type        = string
  default     = "Demo-Terraform"
}

variable "environment" {
  description = "Environment in which the resources will be created"
  type        = string
  default     = "stage"
}
