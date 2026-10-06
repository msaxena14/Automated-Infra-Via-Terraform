# =============================================================================
# prod environment — variable overrides
# db_master_password is intentionally left empty here.
# Set it via: export TF_VAR_db_master_password="..."
#
# All parameter values below match the live RDS configuration as validated
# on 2026-04-22. Update this file whenever a parameter is changed on RDS.
# =============================================================================

aws_region  = "us-east-1"
environment = "staging"
kms_key_id  = "arn:aws:kms:us-east-1:259828991353:key/42908e0a-10e2-438f-9240-ab0e7778e027"

# ── Cluster identifier ─────────────────────────────────────────────────────────

source_cluster_identifier = "aidbox-staging-iac-perf"

# ── Database ──────────────────────────────────────────────────────────────────

db_name               = "aidbox"
db_master_username    = "aidbox"
db_subnet_group_name  = "vhc-staging"
db_security_group_ids = ["sg-0f33606017a5f1c3c"]

# ── PG family ─────────────────────────────────────────────────────────────────

pg_family = "aurora-postgresql15"

# ── Instance classes ──────────────────────────────────────────────────────────

writer_instance_class    = "db.r8g.xlarge"
reader_id_instance_class = "db.r8g.large"

logical_reader_cluster_identifier = "logical-replication-aidbox-iac-perf"
logical_reader_instance_class     = "db.r8g.large"

# ── Shared autovacuum params (source cluster + logical reader) ────────────────
# Values validated against live RDS on 2026-04-22.

autovacuum_max_workers          = "6"
autovacuum_naptime              = "15"
autovacuum_vacuum_cost_delay    = "2"
autovacuum_vacuum_cost_limit    = "800"
autovacuum_vacuum_scale_factor  = "0.01"
autovacuum_analyze_scale_factor = "0.005"
autovacuum_vacuum_threshold     = "1000"
log_autovacuum_min_duration     = "1000"

# ── Shared query params (source cluster + logical reader) ─────────────────────

gin_pending_list_limit    = "134217728"   # 128MB
default_statistics_target = "200"
log_min_duration_statement = "2000"
random_page_cost           = "1.1"

# ── Source cluster-specific params ────────────────────────────────────────────

# Disabled during bulk load — re-enable after load completes via script 03
autovacuum_enabled               = "0"
max_parallel_maintenance_workers = "8"
max_parallel_workers_per_gather  = "8"
# Off during bulk load for throughput. Set to "on" for production traffic.
synchronous_commit               = "off"
work_mem                         = "65536"    # 64MB cluster default
rds_logical_replication          = "1"        # pending-reboot on live

# ── Writer instance params ────────────────────────────────────────────────────

writer_maintenance_work_mem  = "4194304"   # 4GB
writer_work_mem              = "262144"    # 256MB — overrides cluster 64MB
writer_random_page_cost      = "1.5"       # overrides cluster 1.1
writer_max_parallel_workers  = "16"        # pending-reboot on live
writer_max_worker_processes  = "32"        # pending-reboot on live

# ── Reader-1 instance params ──────────────────────────────────────────────────

reader_id_max_parallel_workers_per_gather = "2"   # r5.large = 2 vCPU

# ── Logical reader instance params ────────────────────────────────────────────

logical_reader_work_mem                        = "65536"    # 64MB — matches source cluster default; previously unset (Aurora default 4MB)
logical_reader_maintenance_work_mem            = "4194304"  # 4GB
logical_reader_max_parallel_workers_per_gather = "4"
logical_reader_max_worker_processes            = "32"       # pending-reboot on live
logical_reader_max_parallel_workers            = "8"        # db.r6gd.2xlarge = 8 vCPU

# ── Networking ────────────────────────────────────────────────────────────────

#vpc_id = "vpc-05c550f6c831ae860"
