variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

# ── Encryption ────────────────────────────────────────────────────────────────

variable "kms_key_id" {
  description = "KMS key ID for Aurora storage encryption"
  type        = string
}

# ── Database ──────────────────────────────────────────────────────────────────

variable "db_name" {
  description = "Aurora database name"
  type        = string
  default     = "aidbox"
}

variable "db_master_username" {
  description = "Aurora master username"
  type        = string
  default     = "aidbox"
  sensitive   = true
}

variable "db_master_password" {
  description = "Aurora master password — set via TF_VAR_db_master_password or terraform.tfvars"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "RDS subnet group name"
  type        = string
  default     = "dappostgres-subnet-group"
}

variable "db_security_group_ids" {
  description = "Security group IDs for the Aurora cluster"
  type        = list(string)
  default     = ["sg-07f2fb6993f1a5651"]
}

# ── PG family ─────────────────────────────────────────────────────────────────

variable "pg_family" {
  description = "Aurora PostgreSQL parameter group family — single source of truth for PG version"
  type        = string
  default     = "aurora-postgresql15"
}

# ── Cluster and ALB names ─────────────────────────────────────────────────────

variable "source_cluster_identifier" {
  description = "Aurora source cluster identifier (writer + reader-1)"
  type        = string
}

# ── Instance classes ──────────────────────────────────────────────────────────

variable "writer_instance_class" {
  description = "Writer instance class"
  type        = string
  default     = "db.r8g.xlarge"
}

variable "reader_id_instance_class" {
  description = "Reader 1 (ID lookups) instance class"
  type        = string
  default     = "db.r8g.large"
}

variable "logical_reader_cluster_identifier" {
  description = "Cluster identifier for the logical reader (search)"
  type        = string
}

variable "logical_reader_instance_class" {
  description = "Logical reader instance class"
  type        = string
  default     = "db.r8g.large"
}

# ── Shared cluster param values (applied to both source and logical reader) ───

variable "autovacuum_vacuum_cost_delay" {
  description = "Autovacuum cost delay (ms)"
  type        = string
  default     = "2"
}

variable "autovacuum_vacuum_cost_limit" {
  description = "Autovacuum cost limit"
  type        = string
  default     = "800"
}

variable "autovacuum_vacuum_scale_factor" {
  description = "Fraction of table size before vacuum"
  type        = string
  default     = "0.01"
}

variable "autovacuum_analyze_scale_factor" {
  description = "Fraction of table size before analyze"
  type        = string
  default     = "0.005"
}

variable "autovacuum_max_workers" {
  description = "Max autovacuum worker processes"
  type        = string
  default     = "6"
}

variable "autovacuum_vacuum_threshold" {
  description = "Min dead tuples before vacuum fires"
  type        = string
  default     = "1000"
}

variable "autovacuum_naptime" {
  description = "Autovacuum sleep time between runs (seconds)"
  type        = string
  default     = "15"
}

variable "log_autovacuum_min_duration" {
  description = "Log autovacuum runs longer than this (ms)"
  type        = string
  default     = "1000"
}

variable "gin_pending_list_limit" {
  description = "GIN pending list size in bytes (128MB = 134217728)"
  type        = string
  default     = "134217728"
}

variable "default_statistics_target" {
  description = "Planner statistics target"
  type        = string
  default     = "200"
}

variable "log_min_duration_statement" {
  description = "Log queries longer than this (ms)"
  type        = string
  default     = "2000"
}

variable "random_page_cost" {
  description = "Planner random page cost (cluster default)"
  type        = string
  default     = "1.1"
}

# ── Source cluster-specific params ────────────────────────────────────────────

variable "autovacuum_enabled" {
  description = "Enable autovacuum on source cluster (0 = disabled during bulk load)"
  type        = string
  default     = "0"
}

variable "max_parallel_maintenance_workers" {
  description = "Max parallel workers for maintenance on source cluster"
  type        = string
  default     = "8"
}

variable "max_parallel_workers_per_gather" {
  description = "Max parallel workers per gather on source cluster"
  type        = string
  default     = "8"
}

variable "synchronous_commit" {
  description = "Synchronous commit mode on source cluster (off during bulk load)"
  type        = string
  default     = "off"
}

variable "work_mem" {
  description = "Per-sort/hash memory at source cluster level (bytes)"
  type        = string
  default     = "65536"
}

variable "rds_logical_replication" {
  description = "Enable logical replication on the source cluster (requires reboot)"
  type        = string
  default     = "1"
}

# ── Writer instance params ────────────────────────────────────────────────────

variable "writer_maintenance_work_mem" {
  description = "Maintenance work mem for writer (bytes)"
  type        = string
  default     = "4194304"
}

variable "writer_work_mem" {
  description = "Per-sort/hash memory for writer (bytes) — overrides cluster default"
  type        = string
  default     = "262144"
}

variable "writer_random_page_cost" {
  description = "Planner random page cost for writer — overrides cluster default"
  type        = string
  default     = "1.5"
}

variable "writer_max_parallel_workers" {
  description = "Max parallel workers for writer (requires reboot)"
  type        = string
  default     = "16"
}

variable "writer_max_worker_processes" {
  description = "Max worker processes for writer (requires reboot)"
  type        = string
  default     = "32"
}

# ── Reader-1 instance params ──────────────────────────────────────────────────

variable "reader_id_max_parallel_workers_per_gather" {
  description = "Max parallel workers per gather for reader-1 (r5.large = 2 vCPU)"
  type        = string
  default     = "2"
}

# ── Logical reader instance params ────────────────────────────────────────────

variable "logical_reader_work_mem" {
  description = "Per-sort/hash memory for logical reader (bytes) — must be set; Aurora default 4MB is insufficient for GIN search"
  type        = string
  default     = "65536"
}

variable "logical_reader_maintenance_work_mem" {
  description = "Maintenance work mem for logical reader (bytes)"
  type        = string
  default     = "4194304"
}

variable "logical_reader_max_parallel_workers_per_gather" {
  description = "Max parallel workers per gather for logical reader"
  type        = string
  default     = "4"
}

variable "logical_reader_max_worker_processes" {
  description = "Max worker processes for logical reader (requires reboot)"
  type        = string
  default     = "32"
}

variable "logical_reader_max_parallel_workers" {
  description = "Max parallel workers for logical reader (requires reboot)"
  type        = string
  default     = "8"
}