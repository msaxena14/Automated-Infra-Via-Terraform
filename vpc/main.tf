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
  // calling the source module
  source = "./public-subnet"  

  // passing the value of vpc_id & cidr_block 
  // genrated from above snippet to public-subnet module
  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

module "private_subnet" {
  source = "./private-subnet"

  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}