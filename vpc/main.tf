provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.project}-${var.environment}-vpc"
  }
}

# creating Elastic IP for NAT-Gateway for pvt-sbnt
resource "aws_eip" "eip" {}

# calling oublic subnet module
module "public-subnet" {
  source = "./public-subnet"  

  // passing the value of vpc_id & cidr_block 
  // genrated from above snippet to public-subnet module
  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

module "private-subnet" {
  source = "./private-subnet"

  vpc_id    = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
}

# calling the internet-gateway module
module "internet-gateway" {
  source = "./internet-gateway"
  vpc_id = aws_vpc.main.id
}

# calling nat-gateway module with passing elaticip
module "nat-gateway" {
  source          = "./nat-gateway"
  private-subnet  = module.private-subnet.subnet_id
  eip_id          = aws_eip.eip.id
}

# calling route-table module
module "route_table" {
  source            = "./route-table"
  vpc_id            = aws_vpc.main.id
  public_subnet_id  = module.public_subnet.id
  private_subnet_id = module.private_subnet.id
}