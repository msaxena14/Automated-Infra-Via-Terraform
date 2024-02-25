resource "aws_route_table" "public" {
    vpc_id = var.vpc_id
 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }
 
    tags = {
        Name = "${var.project}-${var.environment}-Public-Route-Table"
    }
}

resource "aws_route_table" "private" {
    vpc_id = var.vpc_id
 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }
 
    tags = {
        Name = "${var.project}-${var.environment}-Private-Route-Table"
    }
}