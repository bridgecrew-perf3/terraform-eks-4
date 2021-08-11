locals {
  nat_gateway_ids = length(var.nat_gateway_ids) > 0 ? var.nat_gateway_ids : tolist(aws_nat_gateway.nat.*.id)
}

resource "aws_eip" "nat_eip" {
  vpc = true
  # At current state we are kept creation of nat/ip is constant, Future this will change to based on azs
  count = var.create_nat ? 1 : 0
  tags = merge(
    {
      "Name"        = format("%s-eip-%s-%d", var.name, var.environment, count.index + 1)
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

resource "aws_nat_gateway" "nat" {
  # At current state this is mentioned static, will move tho dynamic
  count         = var.create_nat ? 1 : 0
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(var.public_subnets_ids, count.index)
  tags = merge(
    {
      "Name"        = format("%s-nat-gateway-%s-%d", var.name, var.environment, count.index + 1)
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

resource "aws_subnet" "private" {
  count      = (length(var.private_subnets) == length(var.private_subnets)) ? length(var.private_subnets) : 0
  vpc_id     = var.vpc_id
  cidr_block = element(var.private_subnets, count.index)

  availability_zone = var.availability_zones[count.index]

  tags = merge(
    {
      "Name"        = format("%s-%s-%s-%s-%d", var.name, var.environment,var.tier, var.availability_zones[count.index], count.index + 1)
      "Environment" = format("%s", var.environment),
      "Tier"        = var.tier
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


resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name"        = format("%s-%s-%s-rt", var.name, var.environment, var.tier)
      "Environment" = format("%s", var.environment),
      "Tier"        = var.tier
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

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  count                  = var.tier == "RDS" ? 0: length(local.nat_gateway_ids)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(local.nat_gateway_ids, count.index)
  depends_on = [
    aws_nat_gateway.nat,
    aws_route_table.private,
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(tolist(aws_subnet.private.*.id))
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
  depends_on = [
    aws_route.private,
  ]
}
