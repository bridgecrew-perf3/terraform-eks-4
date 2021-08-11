variable "environment" {
  type    = string
  default = "Dev"
}

variable "name" {
  type    = string
  default = "TF-Modules"
}


variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  description = "VPC id for existing vpc to create subnets"
  type        = string
  default     = "vpc-08329a443dbc1c3f8"
}

variable "availability_zones" {
  description = "A list of availability_zones  inside the Region"
  type        = list(string)
  default     = null
}

variable "create_nat" {
  description = "If True, it creates nat gateway"
  type        = bool
  default     = false
}

variable "nat_gateway_ids" {
  type = list
  description = "List of Nat Gateway IDs"
  default     = []
}


variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.12.0/24", "192.168.16.0/24", "192.168.20.0/24"]
}

variable "public_subnets_ids" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "tier" {
  description = "Subnet Tier"
  type        = string
  default     = "master"
}
