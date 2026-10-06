output "cluster_endpoint" {
  description = "Aurora cluster writer endpoint"
  value       = module.rds.cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "Aurora cluster reader endpoint (load-balanced across all readers)"
  value       = module.rds.cluster_reader_endpoint
}

output "writer_endpoint" {
  description = "Writer instance endpoint"
  value       = module.rds.writer_endpoint
}

output "reader_id_endpoint" {
  description = "Reader 1 (ID lookups) instance endpoint"
  value       = module.rds.reader_id_endpoint
}

output "logical_reader_endpoint" {
  description = "Logical reader (search) cluster endpoint — receives FHIR data via logical replication, hosts GIN indexes"
  value       = module.logical_reader.instance_endpoint
}