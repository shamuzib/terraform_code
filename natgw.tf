resource "aws_nat_gateway" "prod-natgw" {
  subnet_id     = aws_subnet.prod-subnet-public[0].id
  allocation_id = aws_eip.prod-eip.id
  tags          = local.common_tags
  depends_on    = [aws_eip.prod-eip]
}

resource "aws_eip" "prod-eip" {
  tags       = local.common_tags
  depends_on = [aws_internet_gateway.prod-igw]
}
