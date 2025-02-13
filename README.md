<!-- BEGIN_TF_DOCS -->

# vpc_endpoints

Module for VPC Endpoints

## Requirements

| Name | Version |
| ---- | ------- |
| aws  | >= 5.0  |

## Inputs

| Name                | Description                                                                                           | Type                                                                                                                                                                          | Default | Required |
| ------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| endpoint_subnet_ids | list of subnet id, where endpoint netwirk interface will be created                                   | `list(string)`                                                                                                                                                                | `[]`    |    no    |
| env                 | Environment name                                                                                      | `string`                                                                                                                                                                      | n/a     |   yes    |
| private_rt_ids      | A list of the identities of the private route tables.                                                 | `list(string)`                                                                                                                                                                | n/a     |   yes    |
| region              | AWS region                                                                                            | `string`                                                                                                                                                                      | n/a     |   yes    |
| service_name        | Service name                                                                                          | `string`                                                                                                                                                                      | n/a     |   yes    |
| sg_port_map         | Port map (number and protocol) for security group configuration, that will be applied to vpc endpoint | <pre>map(object({<br> from_port = number<br> to_port = number<br> protocol = string<br> cidr_blocks = optional(list(string))<br> description = optional(string)<br> }))</pre> | n/a     |   yes    |
| vpc_cidr            | CIDR range of Internal network for egress rules to vpc                                                | `string`                                                                                                                                                                      | `""`    |    no    |
| vpc_id              | VPC id where endpoind will be created                                                                 | `string`                                                                                                                                                                      | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
