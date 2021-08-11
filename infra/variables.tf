variable "shared_credentials_file" {
  type        = string
  description = ""
  default     = "/Users/getitrent/.aws/credentials"
}

variable "profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "region" {
  type        = string
  description = ""
  default     = "us-west-2"
}

############ VPC Details #############
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "example"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "192.168.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "boolean flag to enable/disable ClassicLink for the VPC"
  type        = bool
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment in tags to identidy"
  default     = "Dev"
}
variable "additional_tags" {
  type    = map(string)
  default = {}
}


################For DHCP Options ##############

variable "domain_name" {
  description = "suffix domain name to use by default when resolving non Fully Qualified Domain Names"
  type        = string
  default     = "ec2.internal"
}

variable "domain_name_servers" {
  description = "ist of name servers to configure in /etc/resolv.conf"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

############ Public Subnet Details ##########
variable "availability_zones" {
  description = "A list of availability_zones  inside the Region"
  type        = list(string)
  default     = null
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.4.0/24", "192.168.8.0/24"]
}
variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

########## For Master Subnets #######
variable "create_nat" {
  description = "If True, it creates nat gateway"
  type        = bool
  default     = false
}

variable "eks_private_subnet_cidrs" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.12.0/24", "192.168.16.0/24", "192.168.20.0/24"]
}

variable "tier" {
  description = "Subnet Tier"
  type        = string
  default     = "master"
}
### Database Subnet ######

variable "database_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.12.0/24", "192.168.16.0/24", "192.168.20.0/24"]
}

variable "db_tier" {
  description = "Subnet Tier"
  type        = string
  default     = "RDS"
}

#### For EKS cluster #####
variable "create_eks" {
  type        = bool
  description = "Do you want to create EKS"
  default     = true
}

variable "k8s_version" {
  type        = string
  description = "Desired Kubernetes master version."
  default     = "1.14"
}

variable "enabled_cluster_log_types" {
  type        = list
  description = "A list of the desired control plane logging to enable"
  default     = ["api", "audit"]
}

variable "cluster_log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 90
}

variable "endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false."
  default     = false
}

variable "endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true."
  default     = true
}

variable "public_access_cidrs" {
  type        = list
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled"
  default     = ["0.0.0.0/0"]
}

############# For Managed Node Groups ##########

variable "create_node_group" {
  type        = bool
  description = "Do you want to create Node Group"
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
  default     = "example-dev"
}

variable "node_group_name" {
  type        = string
  description = "description"
  default     = "example"
}

variable "scaling_config" {
  type        = map(string)
  description = "Configuration block with scaling settings"
  default = {
    "desired_size" = 1
    "max_size"     = 1
    "min_size"     = 1
  }
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  default     = "AL2_x86_64"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes. Defaults to 40. Terraform will only perform drift detection if a configuration value is provided"
  default     = 40
}

variable "instance_types" {
  type        = list
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]"
  default     = ["t2.medium"]
}

variable "labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument."
  default = {
    "node_group" = "dev"
  }
}

variable "release_version" {
  type        = string
  description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version"
  default     = "1.14.7-20190927"
}

variable "remote_access" {
  type        = map
  description = "Configuration block with remote access settings"
  default = {
    "ec2_ssh_key"               = null
    "source_security_group_ids" = null
  }
}

########## For RDS Cluster #######
variable "create_security_group" {
  description = "Whether to create security group for RDS cluster"
  type        = bool
  default     = true
}

variable "replica_count" {
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
  default     = 1
}

variable "instance_type" {
  description = "Instance type to use"
  type        = string
  default     = "db.t2.medium"
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  type        = bool
  default     = false
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = ""
}

variable "username" {
  description = "Master DB username"
  type        = string
  default     = "root"
}

variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}
variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 30
}
variable "port" {
  description = "The port on which to accept connections"
  type        = string
  default     = "3306"
}
variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = "5.6.10a"
}

variable "sns_topic_name" {
  type        = string
  description = "The SNS topic to send events to."
  default     = null
}
variable "replica_scale_enabled" {
  description = "Whether to enable autoscaling for RDS Aurora (MySQL) read replicas"
  type        = bool
  default     = false
}
variable "replica_scale_min" {
  description = "Minimum number of replicas to allow scaling for"
  type        = number
  default     = 1
}

################ Kubernetes NameSpaces ######################
variable "create_kube_config" {
  type        = bool
  description = "Do you want to create kubeconfig"
  default     = false
}
