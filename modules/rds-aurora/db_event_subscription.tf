# resource "aws_db_event_subscription" "default" {

#   name_prefix = "rds-event-sub"
#   sns_topic   = var.sns_topic_name

#   source_type = "db-cluster"
#   source_ids  = [aws_rds_cluster.this.id]

#   event_categories = [
#     "availability",
#     "deletion",
#     "failover",
#     "failure",
#     "low storage",
#     "maintenance",
#     "notification",
#     "read replica",
#     "recovery",
#     "restoration",
#   ]
# }
