
# resource "aws_cloudwatch_metric_alarm" "high_blocked_transactions" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-high_blocked_transactions", aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "BlockedTransactions"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Sum"
#   threshold           = var.high_blocked_transactions_threshold
#   alarm_description   = "Aurora Cluster Blocked Transactions > 30 for 5mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Count"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "high_cpu" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-high_cpu", aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = var.high_cpu_threshold
#   alarm_description   = "Aurora Cluster CPU Utilization > 80% for 30mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Percent"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "high_db_connections" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-high_db_connections",aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "DatabaseConnections"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Maximum"
#   threshold           = var.high_db_connections_threshold
#   alarm_description   = "Aurora Cluster DB Connections > 300 for 30mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Count"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "low_freeable_memory" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-low_freeable_memory",aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "6"
#   metric_name         = "FreeableMemory"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Sum"
#   threshold           = var.low_freeable_memory_threshold
#   alarm_description   = "Aurora Cluster Freeable Memory < 1073741824 (1GB) for 5mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Bytes"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "high_select_latency" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-high_select_latency",aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "3"
#   metric_name         = "SelectLatency"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = var.high_select_latency_threshold
#   alarm_description   = "Aurora Cluster Select Latency > 20ms for 15mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Seconds"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "high_insert_latency" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-high_insert_latency",aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "3"
#   metric_name         = "InsertLatency"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = var.high_insert_latency_threshold
#   alarm_description   = "Aurora Cluster Insert Latency > 20ms for 15mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Seconds"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "low_free_storage" {
#   count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count
#   alarm_name          = format("%s-low_free_storage",aws_rds_cluster_instance.this[count.index].identifier)
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "6"
#   metric_name         = "FreeLocalStorage"
#   namespace           = "AWS/RDS"
#   period              = "300"
#   statistic           = "Sum"
#   threshold           = var.low_free_storage_space
#   alarm_description   = "Aurora Instance Free Local Storage Space < 1073741824 (1GB) for 30mins"
#   alarm_actions       = [var.sns_topic_name]
#   ok_actions          = [var.sns_topic_name]
#   unit                = "Bytes"

#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.this[count.index].identifier
#   }
# }
