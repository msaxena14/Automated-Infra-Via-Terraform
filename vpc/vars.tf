variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"  # You can change the default to the desired region
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

variable "vpc_cidr" {
  description = "Provide CIDR Range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
  default     = "subnet-1234"
}

variable "public_subnet_cidr" {
  description = "Provide CIDR Range"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
  default     = "subnet-5678"
}

variable "private_subnet_cidr" {
  description = "Provide CIDR Range"
  type        = string
  default     = "10.0.7.0/24"
}

variable "eip" {
  description = "ElasticIP"
  type = string
  default = "13.14.199.200"
}

variable "igw_id" {
  description = "Internet Gateway ID"
  default     =  "igw-1234567890" 
}