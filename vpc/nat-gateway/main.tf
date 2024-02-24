resource "aws_nat_gateway" "example" {
  allocation_id = var.eip
  subnet_id     = var.private-subnet

  tags = {
    Name = "${var.project}-${var.environment}-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}