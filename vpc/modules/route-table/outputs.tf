output "public" {
  description = "The ID of the subnet"
  value       = aws_route_table.public-rt.id
}

output "private" {
  description = "The ID of the subnet"
  value       = aws_route_table.private-rt.id
}