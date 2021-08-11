# Terraform Module for VPC creation

## Prerequisites

- Terraform 0.12.x
- aws cli

### Use as a Module

```terrraform
module "vpc_resource"{
    source = "git::https://github.com/srijanone/terraform-modules.git//aws/vpc"
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy # Default is default
    additional_tags = var.additional_tags # Must be map(string)
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | > 2.53.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_tags | n/a | `map(string)` | `{}` | no |
| assign\_generated\_ipv6\_cidr\_block | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC | `bool` | `false` | no |
| cidr\_block | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | `"192.168.0.0/16"` | no |
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| domain\_name | suffix domain name to use by default when resolving non Fully Qualified Domain Names | `string` | `"ec2.internal"` | no |
| domain\_name\_servers | ist of name servers to configure in /etc/resolv.conf | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| enable\_classiclink | boolean flag to enable/disable ClassicLink for the VPC | `bool` | `false` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | `false` | no |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| enable\_flow\_logs | Do you want to enable vpc flow logs | `bool` | `true` | no |
| environment | Environment in tags to identidy | `string` | `"Dev"` | no |
| iam\_role\_arn | The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group | `string` | `""` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| log\_destination | The ARN of the logging destination | `string` | `""` | no |
| log\_destination\_type | The type of the logging destination. Valid values: cloud-watch-logs, s3. Default: cloud-watch-logs. | `string` | `"cloud-watch-logs"` | no |
| log\_format | The fields to include in the flow log record, in the order in which they should appear. | `string` | `""` | no |
| log\_retention\_in\_days | Specifies the number of days you want to retain log events in the specified log group | `number` | `90` | no |
| name | Name to be used on all the resources as identifier | `string` | `"Example"` | no |
| traffic\_type | The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL | `string` | `"ALL"` | no |
| vpc\_id | VPC ID to attach to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of VPC |
| default\_network\_acl\_id | The ID of the network ACL created by default on VPC creation |
| default\_route\_table\_id | The ID of the route table created by default on VPC creation |
| default\_security\_group\_id | The ID of the security group created by default on VPC creation |
| flow\_log\_id | The Flow Log ID |
| id | ID of the VPC |
| log\_group\_arn | Amazon Resource Name (ARN) specifying the log group. |
| owner\_id | The ID of the AWS account that owns the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### To-Do

- [ ] VPC Flow log support for s3