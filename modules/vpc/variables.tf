variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}


variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "Example"
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
  default     = false
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

############## VPC Flow logs #############
variable "enable_flow_logs" {
  type        = bool
  description = "Do you want to enable vpc flow logs"
  default     = true
}

variable "traffic_type" {
  type        = string
  description = "The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
  default     = "ALL"
}

variable "iam_role_arn" {
  description = "The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group"
  default     = ""
}

variable "log_destination_type" {
  type        = string
  description = "The type of the logging destination. Valid values: cloud-watch-logs, s3. Default: cloud-watch-logs."
  default     = "cloud-watch-logs"
}

variable "log_destination" {
  type        = string
  description = "The ARN of the logging destination"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = " VPC ID to attach to"
  default     = ""
}

variable "log_format" {
  type        = string
  description = "The fields to include in the flow log record, in the order in which they should appear."
  default     = ""
}

### Cloudwatch logs 
variable "log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 90
}
