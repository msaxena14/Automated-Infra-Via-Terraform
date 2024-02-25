variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
  type        = list(string)
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
 default     = ["10.0.197.0/24", "10.0.198.0/24", "10.0.199.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}