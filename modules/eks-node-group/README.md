# Terraform IAC for AWS Transit Gateway

## Prerequisites

- Terraform 0.12.x
- aws cli

## Usage

```hcl
module "examplenodgroup" {
  source            = "git::https://github.com/srijanone/terraform-modules.git//aws/eks-node-group"
  create_node_group = true
  cluster_name      = "Example"
  node_group_name   = "testgroup"
  k8s_version       = 1.14
  node_role_arn     = "arn:aws:iam::xxx:role/xxxxeks-node-iam-role"
  scaling_config = {
    "desired_size" = 1
    "max_size"     = 1
    "min_size"     = 1
  }
  subnet_ids = ["subnet-xxxx", "subnet-yyyy", "subnet-zzzz"]
  additional_tags = {
    Environment = "dev"
  }
}

```

## Input variables

| Name              | Description                                                                                                                             | Type        |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| additional_tags   | Additional tags you want to add                                                                                                         | map(string) |
| create_node_group | Do you want to create Node Group                                                                                                        | bool        |
| cluster_name      | Name of the EKS Cluster                                                                                                                 | string      |
| node_group_name   | Name of the Node Group                                                                                                                  | string      |
| node_role_arn     | Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group                                             | string      |
| scaling_config    | Configuration block with scaling settings                                                                                               | map(string) |
| subnet_ids        | Identifiers of EC2 Subnets to associate with the EKS Node Group                                                                         | list        |
| ami_type          | Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU | string      |
| ami_type          | Disk size in GiB for worker nodes. Defaults to 40. Terraform will only perform drift detection if a configuration value is provided     | number      |
| instance_types    | Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]                                                   | list        |
| labels            | Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument.                     | map(string) |
| release_version   | AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version                                                    | string      |
| remote_access     | Configuration block with remote access settings                                                                                         | map         |
| k8s_version       | Kubernetes version.                                                                                                                     | string      |

## Outputs

| Name                         | Description                                                     |
| ---------------------------- | --------------------------------------------------------------- |
| arn                          | Amazon Resource Name (ARN) of the EKS Node Group.               |
| id                           | EKS Cluster name and EKS Node Group name separated by a colon   |
| resources_autoscaling_groups | List of objects containing information about AutoScaling Groups |
| resources_autoscaling_groups | Identifier of the remote access EC2 Security Group              |
| status                       | Status of the EKS Node Group                                    |
