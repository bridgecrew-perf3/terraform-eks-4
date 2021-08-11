# AWS Infrastructure example

Baseline Infrastructure of example

## Prerequisites

- Terraform 0.12.x
- aws cli

### Initialize terraform

```bash
cp config.example config
##Update your backend configs
terraform init -backend-config=config
```

**Note:**
Make sure you your config file's s3 bucket configured to right aws account for saving state files
Terraform used default profile for this step.

**Ref Link:** https://www.terraform.io/docs/backends/types/s3.html

### WorkSpaces

Create or use Existing terraform workspaces

```bash
terraform workspace show
terraform workspace list
## create new workspace if not exist
terraform workspace new $workspacename ## AWS OU name(Top level) in this case
terraform workspace list
  default
* dev
# Make sure it is pointing to right workspace, if is not point to right workspace
terraform workspace select $workspacename
```

**Ref Link:** https://www.terraform.io/docs/state/workspaces.html

#### Validate your Terraform

```bash
terraform validate
Success! The configuration is valid.
```

#### Plan your terraform to create resources

```bash
cp dev.tfvars.example dev.tfvars
# Update required Variables
terraform plan -var-file=dev.tfvars -out=final.plan
```

#### Apply terraform plan

```bash
terraform apply final.plan
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.24 |
| aws | ~> 2.60 |
| local | ~> 1.4.0 |

## Providers

| Name | Version |
|------|---------|
| local | ~> 1.4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tags | n/a | `map(string)` | `{}` | no |
| ami\_type | Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2\_x86\_64. Valid values: AL2\_x86\_64, AL2\_x86\_64\_GPU. | `string` | `"AL2_x86_64"` | no |
| assign\_generated\_ipv6\_cidr\_block | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC | `bool` | `false` | no |
| availability\_zones | A list of availability\_zones  inside the Region | `list(string)` | `null` | no |
| backup\_retention\_period | How long to keep backups for (in days) | `number` | `30` | no |
| cidr\_block | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | `"192.168.0.0/16"` | no |
| cluster\_log\_retention\_in\_days | Specifies the number of days you want to retain log events in the specified log group | `number` | `90` | no |
| cluster\_name | Name of the EKS Cluster | `string` | `"example-dev"` | no |
| create\_eks | Do you want to create EKS | `bool` | `true` | no |
| create\_kube\_config | Do you want to create kubeconfig | `bool` | `false` | no |
| create\_nat | If True, it creates nat gateway | `bool` | `false` | no |
| create\_node\_group | Do you want to create Node Group | `bool` | `true` | no |
| create\_security\_group | Whether to create security group for RDS cluster | `bool` | `true` | no |
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| database\_name | Name for an automatically created database on cluster creation | `string` | `""` | no |
| database\_private\_subnets | A list of private subnets inside the VPC | `list(string)` | <pre>[<br>  "192.168.12.0/24",<br>  "192.168.16.0/24",<br>  "192.168.20.0/24"<br>]</pre> | no |
| db\_tier | Subnet Tier | `string` | `"RDS"` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled | `bool` | `true` | no |
| disk\_size | Disk size in GiB for worker nodes. Defaults to 40. Terraform will only perform drift detection if a configuration value is provided | `number` | `40` | no |
| domain\_name | suffix domain name to use by default when resolving non Fully Qualified Domain Names | `string` | `"ec2.internal"` | no |
| domain\_name\_servers | ist of name servers to configure in /etc/resolv.conf | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| eks\_private\_subnet\_cidrs | A list of private subnets inside the VPC | `list(string)` | <pre>[<br>  "192.168.12.0/24",<br>  "192.168.16.0/24",<br>  "192.168.20.0/24"<br>]</pre> | no |
| enable\_classiclink | boolean flag to enable/disable ClassicLink for the VPC | `bool` | `false` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | `true` | no |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| enabled\_cluster\_log\_types | A list of the desired control plane logging to enable | `list` | <pre>[<br>  "api",<br>  "audit"<br>]</pre> | no |
| endpoint\_private\_access | Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false. | `bool` | `false` | no |
| endpoint\_public\_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true. | `bool` | `true` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | `string` | `"aurora"` | no |
| engine\_version | Aurora database engine version. | `string` | `"5.6.10a"` | no |
| environment | Environment in tags to identidy | `string` | `"Dev"` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| instance\_type | Instance type to use | `string` | `"db.t2.medium"` | no |
| instance\_types | Set of instance types associated with the EKS Node Group. Defaults to ["t3.medium"] | `list` | <pre>[<br>  "t2.medium"<br>]</pre> | no |
| k8s\_version | Desired Kubernetes master version. | `string` | `"1.14"` | no |
| labels | Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. | `map(string)` | <pre>{<br>  "node_group": "dev"<br>}</pre> | no |
| name | Name to be used on all the resources as identifier | `string` | `"example"` | no |
| node\_group\_name | description | `string` | `"example"` | no |
| password | Master DB password | `string` | `""` | no |
| port | The port on which to accept connections | `string` | `"3306"` | no |
| profile | n/a | `string` | `"default"` | no |
| public\_access\_cidrs | List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| public\_subnet\_suffix | Suffix to append to public subnets name | `string` | `"public"` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | <pre>[<br>  "192.168.1.0/24",<br>  "192.168.4.0/24",<br>  "192.168.8.0/24"<br>]</pre> | no |
| publicly\_accessible | Whether the DB should have a public IP address | `bool` | `false` | no |
| region | n/a | `string` | `"us-west-2"` | no |
| release\_version | AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version | `string` | `"1.14.7-20190927"` | no |
| remote\_access | Configuration block with remote access settings | `map` | <pre>{<br>  "ec2_ssh_key": null,<br>  "source_security_group_ids": null<br>}</pre> | no |
| replica\_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | `number` | `1` | no |
| replica\_scale\_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | `bool` | `false` | no |
| replica\_scale\_min | Minimum number of replicas to allow scaling for | `number` | `1` | no |
| scaling\_config | Configuration block with scaling settings | `map(string)` | <pre>{<br>  "desired_size": 1,<br>  "max_size": 1,<br>  "min_size": 1<br>}</pre> | no |
| shared\_credentials\_file | n/a | `string` | `"/Users/username/.aws/credentials"` | no |
| sns\_topic\_name | The SNS topic to send events to. | `string` | `null` | no |
| tier | Subnet Tier | `string` | `"master"` | no |
| username | Master DB username | `string` | `"root"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
