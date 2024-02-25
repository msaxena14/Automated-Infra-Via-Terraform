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

variable "vpc_id" {
  description = "Provide VPC ID"
  type        = string
}

variable "igw_id" {
  description = "Provide IGW ID"
}

variable "nat_gateway_id" {
    description = "Provide NAT-Gateway ID"
}

variable "public_subnet_ids" {
  description = "Provide public_subnet_id"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Provide private_subnet_id"
  type        = list(string)
}