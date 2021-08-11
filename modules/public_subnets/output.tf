output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw[0].id
}

output "public_subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_arns" {
  description = " The ARN of the subnets"
  value       = aws_subnet.public.*.arn
}

output "aws_route_table_ids" {
  description = "The ID of the routing table"
  value       = aws_route_table.public.*.id
}
