resource "aws_internet_gateway" "igw" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name"        = format("%s-igw-%s", var.name, var.environment)
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

resource "aws_subnet" "public" {
  count             = (length(var.public_subnets) == length(var.availability_zones)) ? length(var.public_subnets) : 0
  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    {
      "Name"        = format("%s-%s-%s-%s-%d", var.name, var.environment, var.public_subnet_suffix, var.availability_zones[count.index], count.index + 1)
      "Environment" = format("%s", var.environment),
      "Tier"        = var.public_subnet_suffix
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

resource "aws_route_table" "public" {
  count  = (length(var.public_subnets) == length(var.availability_zones)) ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name"        = format("%s-%s-%s-rt-%s-%d", var.name, var.environment, var.public_subnet_suffix, var.availability_zones[count.index], count.index + 1)
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

resource "aws_route" "public" {
  count = length(aws_route_table.public.*.id)

  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = concat(aws_internet_gateway.igw.*.id, [""])[0]
  depends_on             = [aws_internet_gateway.igw, aws_route_table.public]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_route_table.public.*.id)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
  depends_on     = [aws_route.public]
  lifecycle {
    create_before_destroy = true
  }
}
