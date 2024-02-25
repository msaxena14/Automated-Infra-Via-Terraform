resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
 
  tags = {
    Name = "${var.project}-${var.environment}-Private-Subnet-${count.index + 1}"
  }
}