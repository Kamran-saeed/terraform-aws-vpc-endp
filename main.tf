resource "aws_security_group" "endpoint" {
  name = "${var.env}-${var.service_name}-vpc-endpoint-sg"

  description = "Security Group to allow traffic to interface endpoint"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_port_map
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = var.vpc_cidr != "" ? [var.vpc_cidr] : ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.env}-${var.service_name}-vpc-endpoint-sg"
  }
}

// VPC endpoint for ec2 service
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-ec2-vpce"
  }
}

// VPC endpoint for ec2 autoscaling
resource "aws_vpc_endpoint" "ec2_autoscaling" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.autoscaling"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-ec2-autoscaling-vpce"
  }
}

// VPC endpoint for ec2 messages
resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-ec2messages-vpce"
  }
}

// VPC endpoint for ssm messages
resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-ssm-messages-vpce"
  }
}

// VPC endpoint for ssm service
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-ssm-vpce"
  }
}

// VPC endpoint for cloudwatch service
resource "aws_vpc_endpoint" "cloudWatch" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.endpoint_subnet_ids

  private_dns_enabled = true

  tags = {
    Name = "${var.env}-${var.service_name}-cloudwatch-vpce"
  }
}

// VPC endpoint for s3 service
module "s3_gateway_vpce" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.0"

  vpc_id                = var.vpc_id
  create_security_group = false

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = var.private_rt_ids
    }
  }

  tags = {
    Name = "${var.env}-${var.service_name}-s3-vpce"
  }
}
