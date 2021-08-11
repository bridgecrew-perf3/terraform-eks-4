variable "environment" {
  type    = string
  default = "Dev"
}

variable "name" {
  type    = string
  default = "Example"
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  description = "VPC id for existing vpc to create subnets"
  type        = string
  default     = null
}

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
  default     = "Public"
}

variable "nacl_ingress_rules" {
  type = list(object({
    from_port  = number
    to_port    = number
    rule_no    = number
    action     = string
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      from_port  = 80
      to_port    = 80
      rule_no    = 100
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 443
      to_port    = 443
      rule_no    = 200
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 22
      to_port    = 22
      rule_no    = 300
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 1024
      to_port    = 65535
      rule_no    = 400
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 53
      to_port    = 53
      rule_no    = 500
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 1024
      to_port    = 65535
      rule_no    = 600
      action     = "allow"
      protocol   = "udp"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "nacl_egress_rules" {
  type = list(object({
    from_port  = number
    to_port    = number
    rule_no    = number
    action     = string
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      from_port  = 0
      to_port    = 65535
      rule_no    = 100
      action     = "allow"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port  = 0
      to_port    = 65535
      rule_no    = 200
      action     = "allow"
      protocol   = "udp"
      cidr_block = "0.0.0.0/0"
    }
  ]
}
