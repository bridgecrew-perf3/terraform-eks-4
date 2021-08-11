# Terraform module for creating EKS Cluster

## Prerequisites

- Terraform 0.12.x
- aws cli

## Available features

- IAM Roles and permissions
- Security Groups for Control plane and Worker Nodes
- Cloud-watch Log Group for EKS logs

## Usage

```hcl
module "eks" {
  source                     = "git::https://github.com/srijanone/terraform-modules.git//aws/eks"
  create_eks                 = true
  cluster_name               = "Example"
  k8s_version                = 1.14
  enabled_cluster_log_types  = ["api"]
  endpoint_private_access    = true
  endpoint_public_access     = true
  public_access_cidrs        = ["192.168.1.1/24"]
  vpc_id                     = "vpc-xxxx"
  cluster_security_group_ids = ["sg-xxxx", "sg-yyyy"]
  worker_security_group_ids  = ["sg-xxxx"]
  subnet_ids                 = ["subnet-xxxx", "subnet-yyyy", "subnet-zzzz"]
  additional_tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name                          | Description                                                                                                                                                                                                                               |    Type     |         Default          | Required |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------: | :----------------------: | :------: |
| additional_tags               | Additional tags used for resources                                                                                                                                                                                                        | map(string) | {"createdby" = "devops"} |    No    |
| create_eks                    | Do you want to create EKS                                                                                                                                                                                                                 |    bool     |           true           |   yes    |
| cluster_name                  | Name of the cluster                                                                                                                                                                                                                       |   string    |       example-dev        |   yes    |
| k8s_version                   | Desired Kubernetes master version.                                                                                                                                                                                                        |   string    |           1.14           |    No    |
| enabled_cluster_log_types     | A list of the desired control plane logging to enable                                                                                                                                                                                     |    list     |     ["api", "audit"]     |    No    |
| cluster_log_retention_in_days | Specifies the number of days you want to retain log events in the specified log group                                                                                                                                                     |   number    |            90            |    No    |
| endpoint_private_access       | Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false                                                                                                                                          |    bool     |          false           |    No    |
| endpoint_public_access        | Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true                                                                                                                                            |    bool     |           true           |    No    |
| public_access_cidrs           | List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled                                                                                                                        |    list     |      ["0.0.0.0/0"]       |    No    |
| vpc_id                        | The VPC associated with your cluster                                                                                                                                                                                                      |   string    |           null           |   Yes    |
| cluster_security_group_ids    | List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane                                              |    list     |            []            |    No    |
| worker_security_group_ids     | Security Group ID for Allowing pods to communicate with the EKS cluster API. only needed if you are not passing 'security_group_ids'                                                                                                      |    list     |            []            |    No    |
| subnet_ids                    | List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane. |    list     |            []            |   Yes    |

## Outputs

| Name                          | Description                                                                   |
| ----------------------------- | ----------------------------------------------------------------------------- |
| master_role_arn               | The Amazon Resource Name (ARN) specifying the role                            |
| master_role_create_date       | The creation date of the IAM role                                             |
| master_role_id                | The name of the role                                                          |
| master_role_name              | The name of the role                                                          |
| master_role_unique_id         | The stable and unique string identifying the role                             |
| nodes_role_arn                | The Amazon Resource Name (ARN) specifying the role                            |
| nodes_role_create_date        | The creation date of the IAM role                                             |
| nodes_role_id                 | The name of the role                                                          |
| nodes_role_name               | The name of the role                                                          |
| nodes_role_unique_id          | The stable and unique string identifying the role                             |
| master_sg_id                  | The ID of the security group                                                  |
| master_sg_arn                 | The ARN of the security group                                                 |
| master_sg_ingress_rules       | The ingress rules                                                             |
| master_sg_egress_rules        | The egress rules                                                              |
| worker_nodes_sg_id            | The ID of the security group                                                  |
| worker_nodes_sg_arn           | The ARN of the security group                                                 |
| worker_nodes_sg_ingress_rules | The ingress rules                                                             |
| worker_nodes_sg_egress_rules  | The egress rules                                                              |
| eks_clg_arn                   | The Amazon Resource Name (ARN) specifying the log group                       |
| eks_id                        | The name of the cluster                                                       |
| eks_arn                       | The Amazon Resource Name (ARN) of the cluster.                                |
| eks_certificate_authority     | The base64 encoded certificate data required to communicate with your cluster |
| eks_endpoint                  | The endpoint for your Kubernetes API server                                   |
| eks_platform_version          | The platform version for the cluster                                          |
| eks_status                    | The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED      |
| eks_version                   | The Kubernetes server version for the cluster.                                |
| eks_vpc_config                | The cluster security group that was created by Amazon EKS for the cluster.    |
