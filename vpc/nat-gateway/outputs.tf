output "nat_gateway_id" {
  description = "The ID of the subnet"
  value       = aws_nat_gateway.nat.id
}