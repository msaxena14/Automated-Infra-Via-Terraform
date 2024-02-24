provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.vpc_name}-${var.environment}-vpc"
  }
}

module "public_subnet" {
  source = "./public-subnet"  // Path to the public-subnet module

  // Pass any required variables to the module
  // For example, if your module requires a vpc_id and a cidr_block, you might do:
  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

module "private_subnet" {
  source = "./private-subnet"  // Path to the public-subnet module

  // Pass any required variables to the module
  // For example, if your module requires a vpc_id and a cidr_block, you might do:
  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}