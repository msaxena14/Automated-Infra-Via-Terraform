variable "eip" {
    description = "The ID of the Elastic IP address"
    type        = string
}

variable "private-subnet" {
    description = "The ID of the Elastic IP address"
    type        = string
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
