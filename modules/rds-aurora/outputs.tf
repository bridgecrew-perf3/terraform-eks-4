// aws_rds_cluster
output "rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.arn
}

output "rds_cluster_id" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.id
}

output "rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = aws_rds_cluster.this.cluster_resource_id
}

output "rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

// database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "rds_cluster_master_password" {
  description = "The master password"
  value       = aws_rds_cluster.this.master_password
}

output "rds_cluster_port" {
  description = "The port"
  value       = aws_rds_cluster.this.port
}

output "rds_cluster_master_username" {
  description = "The master username"
  value       = aws_rds_cluster.this.master_username
}

// aws_rds_cluster_instance
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

output "rds_cluster_instance_ids" {
  description = "A list of all cluster instance identifiers"
  value       = aws_rds_cluster_instance.this.*.identifier
}

// aws_security_group
output "rds_security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}
