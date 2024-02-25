# fetching value of default route-table
output "default_route_table_id" {
  value = data.aws_vpc.main.default_route_table_id
}