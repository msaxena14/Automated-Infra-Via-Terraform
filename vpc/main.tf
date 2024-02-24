provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.project}-${var.environment}-vpc"
  }
}

module "public-subnet" {
  // calling the public module
  source = "./public-subnet"  

  // passing the value of vpc_id & cidr_block 
  // genrated from above snippet to public-subnet module
  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

module "private-subnet" {
  // calling the private module
  source = "./private-subnet"

  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

module "internet-gateway" {
  // calling the internet-gateway module
  source = "./internet-gateway"
  vpc_id = aws_vpc.main.id
}

module "nat_gateway" {
  source     = "./nat-gateway"
  private-subnet = module.private-subnet.subnet_id
  eip_id     = module.eip.id
}