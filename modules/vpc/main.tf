#### VPC ####

resource "aws_vpc" "this" {
  count                            = var.create_vpc ? 1 : 0
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      "Name"        = format("%s-vpc-%s", var.name, var.environment)
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

#### DHCP Options ####

resource "aws_vpc_dhcp_options" "this" {
  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers
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

#### DHCP Association ####

resource "aws_vpc_dhcp_options_association" "this" {
  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this.id
}

#### VPC Flow Logs ####

resource "aws_flow_log" "this" {
  count                = var.enable_flow_logs ? 1 : 0
  traffic_type         = var.traffic_type
  iam_role_arn         = var.iam_role_arn == "" ? aws_iam_role.this[0].arn : var.iam_role_arn
  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination == "" ? aws_cloudwatch_log_group.this[0].arn : var.log_destination
  vpc_id               = var.vpc_id == "" ? aws_vpc.this[0].id : var.vpc_id
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
