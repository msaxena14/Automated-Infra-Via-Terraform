resource "aws_nat_gateway" "nat" {
  allocation_id = var.eip_id
  subnet_id     = var.private-subnet[0]

  tags = {
    Name = "${var.project}-${var.environment}-nat-gw"
  }
}