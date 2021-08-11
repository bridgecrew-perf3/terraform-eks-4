# Terraform Module for VPC creation

## Prerequisites

- Terraform 0.12.x
- aws cli

### Use as a Module

```terrraform
module "vpc_resource"{
    source = "git::https://github.com/srijanone/terraform-modules.git//aws/public_subnets"
    shared_credentials_file = var.shared_credentials_file
    profile = var.profile # Default
    region = var.region
    vpc_id = module.vpc.id # If this variable not passed it will use data module to fetch vpc id
    additional_tags = var.additional_tags # Must be map(string)
    public_subnets = var.public_subnets # Must be list(string)
    availability_zones = var.availability_zones # If this variable not passed it will use data module to fetch azs
    environment = var.environment
    name        = var.name
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
| availability\_zones | A list of availability\_zones  inside the Region | `list(string)` | n/a | yes |
| environment | n/a | `string` | `"Dev"` | no |
| nacl\_egress\_rules | n/a | <pre>list(object({<br>    from_port  = number<br>    to_port    = number<br>    rule_no    = number<br>    action     = string<br>    protocol   = string<br>    cidr_block = string<br>  }))</pre> | <pre>[<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "tcp",<br>    "rule_no": 100,<br>    "to_port": 65535<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "udp",<br>    "rule_no": 200,<br>    "to_port": 65535<br>  }<br>]</pre> | no |
| nacl\_ingress\_rules | n/a | <pre>list(object({<br>    from_port  = number<br>    to_port    = number<br>    rule_no    = number<br>    action     = string<br>    protocol   = string<br>    cidr_block = string<br>  }))</pre> | <pre>[<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_no": 100,<br>    "to_port": 80<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_no": 200,<br>    "to_port": 443<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_no": 300,<br>    "to_port": 22<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "tcp",<br>    "rule_no": 400,<br>    "to_port": 65535<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 53,<br>    "protocol": "tcp",<br>    "rule_no": 500,<br>    "to_port": 53<br>  },<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "udp",<br>    "rule_no": 600,<br>    "to_port": 65535<br>  }<br>]</pre> | no |
| name | n/a | `string` | `"Example"` | no |
| public\_subnet\_suffix | Suffix to append to public subnets name | `string` | `"Public"` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | <pre>[<br>  "192.168.1.0/24",<br>  "192.168.4.0/24",<br>  "192.168.8.0/24"<br>]</pre> | no |
| vpc\_id | VPC id for existing vpc to create subnets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_route\_table\_ids | The ID of the routing table |
| igw\_id | The ID of the Internet Gateway |
| public\_subnet\_arns | The ARN of the subnets |
| public\_subnet\_ids | The IDs of the subnets |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
