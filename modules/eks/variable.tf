variable "additional_tags" {
  type = map(string)
  default = {
    "createdby" = "devops"
  }
}

#### For EKS Cluster ####
variable "create_eks" {
  type        = bool
  description = "Do you want to create EKS"
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
  default     = "example-dev"
}

variable "k8s_version" {
  type        = string
  description = "Desired Kubernetes master version."
  default = "1.17"
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

### vpc_config Details

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

variable "vpc_id" {
  type        = string
  description = "The VPC associated with your cluster."
  default     = null
}

variable "cluster_security_group_ids" {
  type        = list
  description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
  default     = []
}

variable "worker_security_group_ids" {
  type        = list
  description = "Security Group ID for Allowing pods to communicate with the EKS cluster API. only needed if you are not passing 'security_group_ids'"
  default     = []
}

variable "subnet_ids" {
  type        = list
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
  default     = []
}
