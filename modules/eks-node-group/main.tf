resource "aws_eks_node_group" "this" {
  count = var.create_node_group ? 1: 0
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.scaling_config["desired_size"]
    max_size     = var.scaling_config["max_size"]
    min_size     = var.scaling_config["min_size"]
  }
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  instance_types  = var.instance_types
  labels          = var.labels
  release_version = var.release_version
  remote_access {
    ec2_ssh_key               = var.remote_access["ec2_ssh_key"]
    source_security_group_ids = var.remote_access["source_security_group_ids"]
  }
  version = var.k8s_version
   tags = merge(
    var.additional_tags,
    {
      "Node_group_name" = var.node_group_name
    }
   )
   lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags,
      remote_access,
    ]
  }
    
}
