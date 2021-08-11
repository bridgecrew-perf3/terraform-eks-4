module "vpc_resource" {
  source               = "../modules/vpc"
  create_vpc           = var.create_vpc
  cidr_block           = var.cidr_block
  name                 = var.name
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  environment          = var.environment
  additional_tags      = local.vpc_tags
  domain_name          = var.domain_name
}

module "public_subnet" {
  source               = "../modules/public_subnets"
  name                 = var.name
  environment          = var.environment
  vpc_id               = module.vpc_resource.id
  availability_zones   = var.availability_zones
  public_subnets       = var.public_subnets
  public_subnet_suffix = var.public_subnet_suffix
  additional_tags      = local.public_subnet_tags
}

module "eks_private_subnets" {
  source             = "../modules/private_subnets"
  name               = var.name
  environment        = var.environment
  vpc_id             = module.vpc_resource.id
  create_nat         = var.create_nat
  availability_zones = var.availability_zones
  private_subnets    = var.eks_private_subnet_cidrs
  additional_tags    = local.private_subnet_tags
  public_subnets_ids = module.public_subnet.public_subnet_ids
}

# module "database_private_subnet" {
#   source             = "../modules/private_subnets"
#   name               = var.name
#   environment        = var.environment
#   vpc_id             = module.vpc_resource.id
#   create_nat         = false
#   availability_zones = var.availability_zones
#   private_subnets    = var.database_private_subnets
#   nat_gateway_ids    = module.eks_private_subnets.nat_gateway_ids
#   tier               = var.db_tier
#   additional_tags    = local.private_subnet_tags
# }

module "eks" {
  source       = "../modules/eks"
  create_eks   = var.create_eks
  cluster_name = local.cluster_name
  k8s_version  = var.k8s_version

  enabled_cluster_log_types = var.enabled_cluster_log_types
  endpoint_private_access   = var.endpoint_private_access
  endpoint_public_access    = var.endpoint_public_access
  public_access_cidrs       = var.public_access_cidrs
  vpc_id                    = module.vpc_resource.id
  subnet_ids                = concat(module.eks_private_subnets.private_subnet_ids)
  additional_tags = merge(
    var.additional_tags,
    {
      "kubernetes.io/cluster/${var.name}-${var.environment}" = "owned"
    },
    {
      "Environment" = format("%s", var.environment)
    }
  )
}
#### Managed Node Groups ######
module "nodegroup" {
  source          = "../modules/eks-node-group"
  cluster_name    = module.eks.eks_id
  node_group_name = var.node_group_name
  node_role_arn   = module.eks.nodes_role_arn[0]
  scaling_config  = var.scaling_config
  ami_type        = var.ami_type
  subnet_ids      = module.eks_private_subnets.private_subnet_ids
  disk_size       = var.disk_size
  instance_types  = var.instance_types
  labels          = var.labels
  release_version = var.release_version
  remote_access   = var.remote_access
  k8s_version     = var.k8s_version
}

# ##### RDS Aurora Cluster ####
# module "db-cluster" {
#   source            = "../modules/rds-aurora"
#   name              = format("%s-db", local.cluster_name)
#   engine            = var.engine
#   engine_version    = var.engine_version
#   instance_type     = var.instance_type
#   storage_encrypted = true

#   vpc_id                  = module.vpc_resource.id
#   subnets                 = module.database_private_subnet.private_subnet_ids
#   publicly_accessible     = var.publicly_accessible
#   allowed_security_groups = module.eks.worker_nodes_sg_id
#   allowed_cidr_blocks     = [var.cidr_block]

#   replica_count         = var.replica_count
#   replica_scale_enabled = var.replica_scale_enabled

#   database_name           = var.database_name
#   password                = var.password
#   backup_retention_period = var.backup_retention_period
#   apply_immediately       = true
#   monitoring_interval     = 0

#   enabled_cloudwatch_logs_exports = ["slowquery"]
#   additional_tags                 = var.additional_tags
# }
