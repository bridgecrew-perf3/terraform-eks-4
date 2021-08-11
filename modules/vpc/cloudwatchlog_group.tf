resource "aws_cloudwatch_log_group" "this" {
  count             = local.create_log_group
  name              = "/aws/vpc/${var.name}-${var.environment}/logs"
  retention_in_days = var.log_retention_in_days
  tags = merge(
    {
      "Name"        = format("%s-%s", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags,
    ]
  }
}
