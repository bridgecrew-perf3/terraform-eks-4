resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.public.*.id

  // allows traffic from internet to our services behind elb
  // also includes traffic from private subnet to internet through it
  dynamic "ingress" {
    iterator = port
    for_each = var.nacl_ingress_rules
    content {
      from_port  = port.value["from_port"]
      to_port    = port.value["to_port"]
      rule_no    = port.value["rule_no"]
      action     = port.value["action"]
      protocol   = port.value["protocol"]
      cidr_block = port.value["cidr_block"]
    }
  }

  //allows traffic to install any packages

  dynamic "egress" {
    iterator = egresss_rule
    for_each = var.nacl_egress_rules
    content {
      from_port  = egresss_rule.value["from_port"]
      to_port    = egresss_rule.value["to_port"]
      rule_no    = egresss_rule.value["rule_no"]
      action     = egresss_rule.value["action"]
      protocol   = egresss_rule.value["protocol"]
      cidr_block = egresss_rule.value["cidr_block"]
    }
  }

  tags = merge(
    {
      "Name"        = format("%s-%s-%s", var.name, var.environment, "public_subnet_nacl")
      "Environment" = format("%s", var.environment),
      "Tier"        = var.public_subnet_suffix
    },
    var.additional_tags
  )
  
  depends_on = [aws_internet_gateway.igw, aws_subnet.public]

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags,
    ]
  }
}
