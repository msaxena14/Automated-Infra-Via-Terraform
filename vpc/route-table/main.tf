resource "aws_route_table" "second_rt" {
    vpc_id = aws_vpc.main.id
 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
 
    tags = {
        Name = "${var.project}-${var.environment}-Route-Table-2"
    }
}