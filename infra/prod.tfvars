shared_credentials_file = "~/.aws/credentials"
profile                 = "default"
region                  = "us-east-2"

#### For VPC ########
cidr_block  = "10.124.0.0/20"
name        = "hobsons"
environment = "dev"
additional_tags = {
  "Managed by" = "Terraform"
}
#### Public Subent  #####
availability_zones = ["us-east-2a", "us-east-2b"]
public_subnets     = ["10.124.1.0/24", "10.124.2.0/24"]

### For worker_nodes ###
eks_private_subnet_cidrs = ["10.124.6.0/23", "10.124.8.0/23"]
create_nat               = true
tier                     = "eks"

### For Database #####
database_private_subnets = ["10.124.12.0/24", "10.124.14.0/24"]

#### For EKS Cluster ##### 
create_eks              = true
k8s_version             = 1.17
endpoint_private_access = true
endpoint_public_access  = true
public_access_cidrs     = ["0.0.0.0/0"]

############ Node Group Details #######

node_group_name = "dev"
release_version = "1.17.9-20200723"
scaling_config = {
  "desired_size" = 3
  "max_size"     = 6
  "min_size"     = 3
}
disk_size      = 40
instance_types = ["t2.medium"]
labels = {
  "node_group" = "dev-stage"
}

#### For RDS ######

instance_type           = "db.t2.medium"
database_name           = "test"
backup_retention_period = 30
replica_scale_enabled   = false
replica_count           = 2

################# NameSpaces ##########
create_kube_config = true
