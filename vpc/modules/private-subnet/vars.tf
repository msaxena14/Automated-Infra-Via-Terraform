variable "vpc_id" {
  description = "The ID of the VPC"
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

variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.60.32.0/20", "10.60.48.0/20"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}