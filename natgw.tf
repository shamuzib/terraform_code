resource "aws_nat_gateway" "prod-natgw" {
  subnet_id     = aws_subnet.prod-subnet-public[count.index].id #Can be improvised
  allocation_id = aws_eip.prod-eip.id
  tags          = local.common_tags
  depends_on    = [aws_eip.prod-eip]
  count         = 1
}

resource "aws_eip" "prod-eip" {
  tags = local.common_tags
}
