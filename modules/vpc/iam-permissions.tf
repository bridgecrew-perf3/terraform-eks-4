resource "aws_iam_role" "this" {
  count = local.create_iam_role
  name  = format("%s-%s-VPCFlow-Lle", var.name, var.environment)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags = merge(
    {
      "Name"        = format("%s-%s", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
