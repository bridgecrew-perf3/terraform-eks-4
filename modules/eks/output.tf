output "master_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role"
  value       = aws_iam_role.eks-master-role.*.arn
}

output "master_role_create_date" {
  description = "The creation date of the IAM role"
  value       = aws_iam_role.eks-master-role.*.create_date
}

output "master_role_id" {
  description = "The name of the role"
  value       = aws_iam_role.eks-master-role.*.id
}

output "master_role_name" {
  description = "The name of the role"
  value       = aws_iam_role.eks-master-role.*.name
}

output "master_role_unique_id" {
  description = "The stable and unique string identifying the role"
  value       = aws_iam_role.eks-master-role.*.unique_id
}

##### Node Role outputs 
output "nodes_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role"
  value       = aws_iam_role.eks-node-role.*.arn
}

output "nodes_role_create_date" {
  description = "The creation date of the IAM role"
  value       = aws_iam_role.eks-node-role.*.create_date
}

output "nodes_role_id" {
  description = "The name of the role"
  value       = aws_iam_role.eks-node-role.*.id
}

output "nodes_role_name" {
  description = "The name of the role"
  value       = aws_iam_role.eks-node-role.*.name
}

output "nodes_role_unique_id" {
  description = "The stable and unique string identifying the role"
  value       = aws_iam_role.eks-node-role.*.unique_id
}

###### Master SG output
output "master_sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.cluster.*.id
}

output "master_sg_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.cluster.*.arn
}
output "master_sg_ingress_rules" {
  description = "The ingress rules"
  value       = aws_security_group.cluster.*.ingress
}
output "master_sg_egress_rules" {
  description = "The egress rules"
  value       = aws_security_group.cluster.*.egress
}

###### Worker nodes SG output
output "worker_nodes_sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.workers.*.id
}

output "worker_nodes_sg_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.workers.*.arn
}
output "worker_nodes_sg_ingress_rules" {
  description = "The ingress rules"
  value       = aws_security_group.workers.*.ingress
}
output "worker_nodes_sg_egress_rules" {
  description = "The egress rules"
  value       = aws_security_group.cluster.*.egress
}

##### Cloudwatch Log Group for EKS
output "eks_clg_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group"
  value       = aws_cloudwatch_log_group.this.*.arn
}

##### EKS Cluster output Details

output "eks_id" {
  description = "The name of the cluster"
  value       = concat(aws_eks_cluster.this.*.id, [""])[0]
}

output "eks_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = concat(aws_eks_cluster.this.*.arn, [""])[0]
}

output "eks_certificate_authority" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = element(concat(aws_eks_cluster.this[*].certificate_authority[0].data,tolist([""])), 0)
}
output "eks_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = concat(aws_eks_cluster.this.*.endpoint, [""])[0]
}

output "eks_platform_version" {
  description = "The platform version for the cluster"
  value       = concat(aws_eks_cluster.this.*.platform_version, [""])[0]
}

output "eks_status" {
  description = "The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED"
  value       = concat(aws_eks_cluster.this.*.status, [""])[0]
}

output "eks_version" {
  description = "The Kubernetes server version for the cluster."
  value       = concat(aws_eks_cluster.this.*.version, [""])[0]
}

output "eks_vpc_config" {
  description = "The cluster security group that was created by Amazon EKS for the cluster."
  value       = element(concat(aws_eks_cluster.this[*].vpc_config[0].cluster_security_group_id, tolist([""])), 0)
}
