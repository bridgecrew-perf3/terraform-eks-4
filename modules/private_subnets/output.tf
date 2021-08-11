output "private_subnet_ids" {
   value =  aws_subnet.private.*.id
}

output "route_table_id" {
  value = aws_route_table.private.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat.*.id
}
