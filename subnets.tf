resource "aws_subnet" "prod-subnet-public" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = var.subnet_cidr_public[count.index]
  availability_zone       = data.aws_availability_zones.prod-az.names[count.index]
  map_public_ip_on_launch = true
  count                   = length(var.subnet_cidr_public)
  tags                    = local.common_tags
}

resource "aws_subnet" "prod-subnet-private" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = var.subnet_cidr_private[count.index]
  # availability_zone = var.availability-zone-subnet-private
  availability_zone = var.az_public != "" ? var.az_public[count.index % length(var.az_public)] : var.az-private[count.index % length(var.az-private)]
  count             = length(var.subnet_cidr_private)
  tags              = local.common_tags
}
