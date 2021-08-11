locals {
  eks_count            = var.create_eks ? 1 : 0
  create_sg_for_master = length(var.cluster_security_group_ids) <= 0 && var.create_eks ? 1 : 0
  create_sg_for_nodes  = length(var.worker_security_group_ids) <= 0 && var.create_eks ? 1 : 0
}

resource "aws_cloudwatch_log_group" "this" {
  count             = length(var.enabled_cluster_log_types) > 0 && var.create_eks ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cluster_log_retention_in_days
  tags = merge(
    {
      "Name" = var.cluster_name
    },
    var.additional_tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

# Create EKS cluster
resource "aws_eks_cluster" "this" {
  count                     = local.eks_count
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks-master-role[count.index].arn
  version                   = var.k8s_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = length(var.cluster_security_group_ids) > 0 ? var.cluster_security_group_ids : aws_security_group.cluster.*.id
    subnet_ids              = var.subnet_ids
  }

  depends_on = [
    aws_iam_role.eks-master-role,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.this
  ]
  tags = merge(
    {
      "Name" = var.cluster_name
    },
    var.additional_tags
  )
  lifecycle {
    # We cant create more than 1 EKS clusters with the same name, `create_before_destroy` wont work here
    # create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}
