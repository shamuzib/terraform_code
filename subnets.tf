resource "aws_subnet" "prod-subnet-public" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = var.subnet_cidr_public[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  count                   = 2
  tags                    = local.common_tags
}


resource "aws_subnet" "prod-subnet-private-a" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = var.subnet_cidr_private-a[count.index]
  availability_zone = var.availability_zone-a
  count             = 2
  tags              = local.common_tags
}

resource "aws_subnet" "prod-subnet-private-b" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = var.subnet_cidr_private-b[count.index]
  availability_zone = var.availability_zone-b
  count             = 2
  tags              = local.common_tags
}
