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
resource "aws_eip" "eip" {
  tags = {
    Name = "${var.project}-${var.environment}-eip"
  }
}

# calling public subnet module
module "public-subnet" {
  source = "./modules/public-subnet"

  // passing the value of vpc_id & cidr_block 
  // genrated from above snippet to public-subnet module
  vpc_id    = "${aws_vpc.main.id}"
  cidr_block = var.public_subnet_cidr
}

# calling private subnet module
module "private-subnet" {
  source = "./modules/private-subnet"

  vpc_id    = "${aws_vpc.main.id}"
  # cidr_block = var.private_subnet_cidr
  cidr_block = "${module.private-subnet.subnet_id}"
}

# calling the internet-gateway module
module "internet-gateway" {
  source = "./modules/internet-gateway"
  igw_id = "${module.internet-gateway.igw_id}"
  vpc_id = "${aws_vpc.main.id}"
}

# calling nat-gateway module with passing elaticip
module "nat-gateway" {
  source          = "./modules/nat-gateway"
  private-subnet  = "${module.private-subnet.subnet_id}"
  eip_id          = aws_eip.eip.id
}

# calling route-table module
module "route-table" {
  source            = "./modules/route-table"
  vpc_id            = "${aws_vpc.main.id}"
  public_subnet_ids  = "${module.public-subnet.subnet_id[*]}"
  private_subnet_ids = "${module.private-subnet.subnet_id[*]}"
  igw_id            = "${module.internet-gateway.igw_id}"
  nat_gateway_id    = "${module.nat-gateway.nat_gateway_id}"
}