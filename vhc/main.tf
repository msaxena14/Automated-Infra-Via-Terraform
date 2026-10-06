# =============================================================================
# FHIR Storage Layer — staging environment
# Provisions Aurora PostgreSQL cluster and parameter groups for Aidbox FHIR routing.
#
# Teardown:  terraform destroy
# Spawn up:  terraform apply
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = "invcr-terraform-pipeline"
  #   key            = "infra/aidbox-staging/fhir-storage-layer/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "infra-terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
  profile = "vhc"

  default_tags {
    tags = {
      Project     = "vhc"
      Environment = var.environment
      ManagedBy   = "terraform"
      CostCenter  = "vhc-aidbox"
      tenant_id   = "vhc_staging"
    }
  }
}

# ── Parameter Groups ──────────────────────────────────────────────────────────

module "parameter_groups" {
  source = "../../modules/parameter_groups"

  cluster_parameter_group_name   = "${var.source_cluster_identifier}-replica-group"
  writer_parameter_group_name    = "${var.source_cluster_identifier}-instance-group"
  reader_id_parameter_group_name = "${var.source_cluster_identifier}-reader-id-group"

  pg_family = var.pg_family

  # Source cluster params
  autovacuum_enabled               = var.autovacuum_enabled
  autovacuum_max_workers           = var.autovacuum_max_workers
  autovacuum_naptime               = var.autovacuum_naptime
  autovacuum_vacuum_cost_delay     = var.autovacuum_vacuum_cost_delay
  autovacuum_vacuum_cost_limit     = var.autovacuum_vacuum_cost_limit
  autovacuum_vacuum_scale_factor   = var.autovacuum_vacuum_scale_factor
  autovacuum_analyze_scale_factor  = var.autovacuum_analyze_scale_factor
  autovacuum_vacuum_threshold      = var.autovacuum_vacuum_threshold
  log_autovacuum_min_duration      = var.log_autovacuum_min_duration
  gin_pending_list_limit           = var.gin_pending_list_limit
  default_statistics_target        = var.default_statistics_target
  max_parallel_maintenance_workers = var.max_parallel_maintenance_workers
  max_parallel_workers_per_gather  = var.max_parallel_workers_per_gather
  log_min_duration_statement       = var.log_min_duration_statement
  random_page_cost                 = var.random_page_cost
  synchronous_commit               = var.synchronous_commit
  work_mem                         = var.work_mem
  rds_logical_replication          = var.rds_logical_replication

  # Writer instance params
  writer_maintenance_work_mem  = var.writer_maintenance_work_mem
  writer_work_mem              = var.writer_work_mem
  writer_random_page_cost      = var.writer_random_page_cost
  writer_max_parallel_workers  = var.writer_max_parallel_workers
  writer_max_worker_processes  = var.writer_max_worker_processes

  # Reader-1 instance params
  reader_id_max_parallel_workers_per_gather = var.reader_id_max_parallel_workers_per_gather
  reader_id_default_statistics_target       = var.default_statistics_target
}

# ── Aurora Cluster (writer + reader-1 only) ───────────────────────────────────
# Search queries are NOT served from this cluster. They go to the logical reader
# cluster below. This cluster has no GIN indexes — writer handles writes,
# reader-1 handles ID lookups via B-tree only.

module "rds" {
  source = "../../modules/rds"

  cluster_identifier     = var.source_cluster_identifier
  engine_version         = "15.15"
  database_name          = var.db_name
  master_username        = var.db_master_username
  master_password        = var.db_master_password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.db_security_group_ids

  cluster_parameter_group_name   = module.parameter_groups.cluster_parameter_group_name
  writer_parameter_group_name    = module.parameter_groups.writer_parameter_group_name
  reader_id_parameter_group_name = module.parameter_groups.reader_id_parameter_group_name

  writer_instance_class    = var.writer_instance_class
  reader_id_instance_class = var.reader_id_instance_class
  kms_key_id               = var.kms_key_id

  depends_on = [module.parameter_groups]
}

# ── Logical Reader (search) ───────────────────────────────────────────────────
# Standalone Aurora cluster receiving FHIR data via PostgreSQL logical replication
# from aidbox-staging-cluster. Independent storage means GIN indexes exist ONLY
# here — no GIN overhead on the source cluster.
# Logical replication wiring: run scripts/11_logical_replication_source.sql on
# the writer, then scripts/12_logical_replication_target.sql on this cluster.

module "logical_reader" {
  source = "../../modules/logical_reader"

  cluster_identifier     = var.logical_reader_cluster_identifier
  engine_version         = "15.15"
  pg_family              = var.pg_family
  database_name          = var.db_name
  master_username        = var.db_master_username
  master_password        = var.db_master_password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.db_security_group_ids
  instance_class         = var.logical_reader_instance_class

  # Cluster-level params — shared values with source cluster where applicable
  max_parallel_workers_per_gather = var.logical_reader_max_parallel_workers_per_gather
  default_statistics_target       = var.default_statistics_target
  gin_pending_list_limit          = var.gin_pending_list_limit
  autovacuum_vacuum_cost_delay    = var.autovacuum_vacuum_cost_delay
  autovacuum_vacuum_cost_limit    = var.autovacuum_vacuum_cost_limit
  autovacuum_vacuum_scale_factor  = var.autovacuum_vacuum_scale_factor
  autovacuum_analyze_scale_factor = var.autovacuum_analyze_scale_factor
  autovacuum_max_workers          = var.autovacuum_max_workers
  autovacuum_vacuum_threshold     = var.autovacuum_vacuum_threshold
  autovacuum_naptime              = var.autovacuum_naptime
  log_autovacuum_min_duration     = var.log_autovacuum_min_duration
  log_min_duration_statement      = var.log_min_duration_statement
  random_page_cost                = var.random_page_cost

  # Instance-level params
  maintenance_work_mem                     = var.logical_reader_maintenance_work_mem
  work_mem                                 = var.logical_reader_work_mem
  instance_max_parallel_workers_per_gather = var.logical_reader_max_parallel_workers_per_gather
  max_worker_processes                     = var.logical_reader_max_worker_processes
  max_parallel_workers                     = var.logical_reader_max_parallel_workers
  instance_default_statistics_target       = var.default_statistics_target
  kms_key_id                               = var.kms_key_id
}