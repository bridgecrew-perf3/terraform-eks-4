output "arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = concat(aws_eks_node_group.this.*.arn,[""])[0]
}

output "id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon"
  value       = concat(aws_eks_node_group.this.*.id,[""])[0]
}

output "resources_autoscaling_groups" {
  description = "List of objects containing information about AutoScaling Groups"
  value       = element(concat(aws_eks_node_group.this[*].resources[0].autoscaling_groups, tolist([""])), 0)
}

### This output is returning error message
# **** This value does not have any attributes.****
# output "resources_autoscaling_groups_name" {
#   description = "Name of the AutoScaling Group"
#   value       = element(concat(aws_eks_node_group.this[*].resources[0].name, list("")), 0)
# }

output "resources_autoscaling_groups_remote_access_security_group_id" {
  description = "Identifier of the remote access EC2 Security Group"
  value       = element(concat(aws_eks_node_group.this[*].resources[0].remote_access_security_group_id, tolist([""])), 0)
}
output "status" {
  description = "Status of the EKS Node Group"
  value       = concat(aws_eks_node_group.this.*.status, [""])[0]
}
