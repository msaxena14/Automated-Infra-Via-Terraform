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

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.60.0.0/20", "10.60.16.0/20"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}