# Terraform Module for Private Subnet creation

## Prerequisites

- Terraform 0.12.x
- aws cli

## Input variables

| Name               | Description                                        | Type         |
| ------------------ | -------------------------------------------------- | ------------ |
| name               | Name to be used on all the resources as identifier | String       |
| environment        | Environment in tags to identidy                    | string       |
| additional_tags    | additional tags for resouce                        | map(string)  |
| vpc_id             | VPC id for existing vpc to create subnets          | string       |
| create_nat         | If True, it creates nat gateway                    | Bool         |
| availability_zones | list of availability_zones inside the Region       | list(string) |
| private_subnets    | A list of public subnets inside the VPC            | list(string) |
| tier               | Subent Tier                                        | String       |
| nat_gateway_ids    | List of Nat Gateway IDs                            | list         |
| public_subnets_ids | A list of private subnets inside the VPC           | list         |

**Note**: You can setup the variables using **.tfvars** or as env variables.

Link: https://www.terraform.io/docs/configuration/variables.html

### Use as Standalone TF template

```bash
terraform init
terraform workspace create workspace_name
terraform workspace select workspace_name
terraform plan
terraform apply
```

**Note**: It uses Default Variables to create Subenets in given VPC

### Use as a Module

```terrraform
module "private_subnet_tier1"{
    source = "git::https://github.com/srijanone/terraform-modules.git//aws/private_subnets"
    vpc_id = module.vpc.id # If this variable not passed it will use data module to fetch vpc id
    additional_tags = var.additional_tags # Must be map(string)
    private_subnets = var.public_subnets # Must be list(string)
    availability_zones = var.availability_zones # If this variable not passed it will use data module to fetch azs
    environment = var.environment
    name        = var.name
    tier = var.tier # name of subnet tier ex: web/app/db, etc
}
```

### Output variables

| Name               | Description                           |
| ------------------ | ------------------------------------- |
| nat_gateway_ids    | The ID of the Nat Gateway             |
| private_subnet_ids | The IDs of the private subnets        |
| route_table_id     | The IDs of the private routing tables |
