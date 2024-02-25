variable "eip_id" {
  description = "The ID of the Elastic IP address"
}

variable "private-subnet" {
  description = "The ID of the Elastic IP address"
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
