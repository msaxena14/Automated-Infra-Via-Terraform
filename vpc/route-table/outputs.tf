output "public" {
  description = "The ID of the subnet"
  value       = aws_route_table.public.id
}

output "private" {
  description = "The ID of the subnet"
  value       = aws_route_table.private.id
}