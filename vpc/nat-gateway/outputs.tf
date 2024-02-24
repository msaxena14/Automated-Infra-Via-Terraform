output "nat_gateway" {
  description = "The ID of the subnet"
  value       = aws_nat_gateway.nat.id
}