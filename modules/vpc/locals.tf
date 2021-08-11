locals {
  create_log_group = var.log_destination == "" && var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  create_iam_role  = var.iam_role_arn == "" && var.log_destination == "" && var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  vpc_id           = var.vpc_id == "" ? concat(aws_vpc.this.*.id, [""])[0] : var.vpc_id
}
