variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "VPC Provisioned via terraform"
  type        = string
  default     = "poc-eks-argocd"
}

variable "team" {
  description = "Team name"
  type        = string
  default     = "infra-team"
}

variable "environment" {
  description = "Environment in which the resources will be created"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Provide CIDR Range"
  type        = string
  default     = "10.60.0.0/16"
}

variable "azs" {
  description = "Availability Zones to spread subnets across"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.60.0.0/20", "10.60.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR values"
  type        = list(string)
  default     = ["10.60.32.0/20", "10.60.48.0/20"]
}