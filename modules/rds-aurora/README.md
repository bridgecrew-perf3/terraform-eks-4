# Terraform module for creating RDS aurora Cluster.

## Prerequisites

- Terraform 0.12.x
- aws cli

## Available features

- Autoscaling of read-replicas (based on CPU utilization)
- Enhanced Monitoring

## Usage

```hcl
module "db" {
  source  = "git::https://github.com/srijanone/terraform-modules.git//aws/rds-aurora"

  name                            = "test-aurora-db-postgres96"

  engine                          = "aurora-postgresql"
  engine_version                  = "9.6.9"

  vpc_id                          = "vpc-12345678"
  subnets                         = ["subnet-12345678", "subnet-87654321"]

  replica_count                   = 1
  allowed_security_groups         = ["sg-12345678"]
  allowed_cidr_blocks             = ["10.20.0.0/20"]
  instance_type                   = "db.r4.large"
  storage_encrypted               = true
  apply_immediately               = true
  monitoring_interval             = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  sns_topic_name = "example"
  additional_tags                            = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed_cidr_blocks | A list of CIDR blocks which are allowed to access the database | list(string) | `[]` | no |
| allowed_security_groups | A list of Security Group ID's to allow access to. | list | `[]` | no |
| apply_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | bool | `"false"` | no |
| auto_minor_version_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | bool | `"true"` | no |
| backtrack_window | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours) | number | `"0"` | no |
| backup_retention_period | How long to keep backups for (in days) | number | `"7"` | no |
| copy_tags_to_snapshot | Copy all Cluster tags to snapshots. | bool | `"false"` | no |
| create_security_group | Whether to create security group for RDS cluster | bool | `"true"` | no |
| database_name | Name for an automatically created database on cluster creation | string | `""` | no |
| db_cluster_parameter_group_name | The name of a DB Cluster parameter group to use | string | `"null"` | no |
| db_parameter_group_name | The name of a DB parameter group to use | string | `"null"` | no |
| db_subnet_group_name | The existing subnet group name to use | string | `""` | no |
| deletion_protection | If the DB instance should have deletion protection enabled | bool | `"false"` | no |
| enabled_cloudwatch_logs_exports | List of log types to export to cloudwatch | list(string) | `[]` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `"aurora"` | no |
| engine_mode | The database engine mode. Valid values: global, parallelquery, provisioned, serverless. | string | `"provisioned"` | no |
| engine_version | Aurora database engine version. | string | `"5.6.10a"` | no |
| final_snapshot_identifier_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `"final"` | no |
| global_cluster_identifier | The global cluster identifier specified on aws_rds_global_cluster | string | `""` | no |
| iam_database_authentication_enabled | Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported. | bool | `"false"` | no |
| iam_roles | A List of ARNs for the IAM roles to associate to the RDS Cluster. | list(string) | `[]` | no |
| instance_type | Instance type to use | string | n/a | yes |
| kms_key_id | The ARN for the KMS encryption key if one is set to the cluster. | string | `""` | no |
| monitoring_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | number | `"0"` | no |
| name | Name given resources | string | n/a | yes |
| password | Master DB password | string | `""` | no |
| performance_insights_enabled | Specifies whether Performance Insights is enabled or not. | bool | `"false"` | no |
| performance_insights_kms_key_id | The ARN for the KMS key to encrypt Performance Insights data. | string | `""` | no |
| port | The port on which to accept connections | string | `""` | no |
| predefined_metric_type | The metric type to scale on. Valid values are RDSReaderAverageCPUUtilization and RDSReaderAverageDatabaseConnections. | string | `"RDSReaderAverageCPUUtilization"` | no |
| preferred_backup_window | When to perform DB backups | string | `"02:00-03:00"` | no |
| preferred_maintenance_window | When to perform DB maintenance | string | `"sun:05:00-sun:06:00"` | no |
| publicly_accessible | Whether the DB should have a public IP address | bool | `"false"` | no |
| replica_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `"1"` | no |
| replica_scale_connections | Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max_connections | number | `"700"` | no |
| replica_scale_cpu | CPU usage to trigger autoscaling at | number | `"70"` | no |
| replica_scale_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | bool | `"false"` | no |
| replica_scale_in_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | number | `"300"` | no |
| replica_scale_max | Maximum number of replicas to allow scaling for | number | `"0"` | no |
| replica_scale_min | Minimum number of replicas to allow scaling for | number | `"2"` | no |
| replica_scale_out_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | number | `"300"` | no |
| replication_source_identifier | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | string | `""` | no |
| scaling_configuration | Map of nested attributes with scaling properties. Only valid when engine_mode is set to `serverless` | map(string) | `{}` | no |
| security_group_description | The description of the security group. If value is set to empty string it will contain cluster name in the description. | string | `"Managed by Terraform"` | no |
| skip_final_snapshot | Should a final snapshot be created on cluster destroy | bool | `"false"` | no |
| snapshot_identifier | DB snapshot to create this database from | string | `""` | no |
| source_region | The source region for an encrypted replica DB cluster. | string | `""` | no |
| storage_encrypted | Specifies whether the underlying storage layer should be encrypted | bool | `"true"` | no |
| subnets | List of subnet IDs to use | list(string) | `[]` | no |
| additional_tags | A map of tags to add to all resources. | map(string) | `{}` | no |
| username | Master DB username | string | `"root"` | no |
| vpc_id | VPC ID | string | n/a | yes |
| vpc_security_group_ids | List of VPC security groups to associate to the cluster in addition to the SG we create in this module | list(string) | `[]` | yes |
|sns_topic_name|The SNS topic to send events to.| string | nill | no |

## Outputs

| Name | Description |
|------|-------------|
| rds_cluster_arn | The ID of the cluster |
| rds_cluster_database_name | Name for an automatically created database on cluster creation |
| rds_cluster_endpoint | The cluster endpoint |
| rds_cluster_id | The ID of the cluster |
| rds_cluster_instance_endpoints | A list of all cluster instance endpoints |
| rds_cluster_master_password | The master password |
| rds_cluster_master_username | The master username |
| rds_cluster_port | The port |
| rds_cluster_reader_endpoint | The cluster reader endpoint |
| rds_cluster_resource_id | The Resource ID of the cluster |
| rds_security_group_id | The security group ID of the cluster |
