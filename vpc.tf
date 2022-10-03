resource "aws_vpc" "prod-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags             = local.common_tags
}