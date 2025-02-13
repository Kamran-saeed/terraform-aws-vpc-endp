variable "service_name" {
  type        = string
  description = "Service name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "sg_port_map" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
    description = optional(string)
  }))
  description = "Port map (number and protocol) for security group configuration, that will be applied to vpc endpoint"
}

variable "vpc_id" {
  type        = string
  description = "VPC id where endpoind will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range of Internal network for egress rules to vpc"
  default     = ""
}

variable "endpoint_subnet_ids" {
  type        = list(string)
  description = "list of subnet id, where endpoint netwirk interface will be created"
  default     = []
}

variable "private_rt_ids" {
  type        = list(string)
  description = "A list of the identities of the private route tables."
}
