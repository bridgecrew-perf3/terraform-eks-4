variable "create_node_group" {
  type = bool
  description = "Do you want to create Node Group"
  default     = true
}

variable "additional_tags" {
  type = map(string)
  default = {
    "createdby" = "devops"
  }
}

######## For Node Group 

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
  default     = "example-dev"
}

variable "node_group_name" {
  type        = string
  description = "Name of the Node Group"
  default     = "example"
}

variable "node_role_arn" {
  type        = string
  description = "Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
  default     = "arn:aws:iam::xxx:role/xxxxeks-node-iam-role"
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

variable "subnet_ids" {
  type        = list
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group."
  default     = ["subnet-xxxx","subnet-xxxx","subnet-xxx"]
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
  default     = {
      "node_group" = "dev"
  }
}

variable "release_version" {
  type        = string
  description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version"
  default     = "1.17.9-20200723"
}

variable "remote_access" {
  type        = map
  description = "Configuration block with remote access settings"
  default     = {
      "ec2_ssh_key" = null
      "source_security_group_ids" = null 
  }
}
variable "k8s_version" {
  type        = string
  description = "Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  default     = "1.14"
}
