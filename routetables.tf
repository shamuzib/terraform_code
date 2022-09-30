resource "aws_route_table" "prod-rt-public" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
  tags = local.common_tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = element(aws_subnet.prod-subnet-public[*].id, count.index)
  route_table_id = aws_route_table.prod-rt-public.id
  count          = 2
}

resource "aws_route_table" "prod-rt-private" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.prod-natgw.id
  }
  tags = local.common_tags
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = element(aws_subnet.prod-subnet-private-a[*].id, count.index)
  route_table_id = aws_route_table.prod-rt-private.id
  count          = 2
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = element(aws_subnet.prod-subnet-private-b[*].id, count.index)
  route_table_id = aws_route_table.prod-rt-private.id
  count          = 2
}

# resource "aws_route_table_association" "public" {
#   subnet_id = "${element(aws_subnet.prod-subnet-public[*].id, count.index)}"
#   route_table_id = aws_route_table.prod-rt-public.id
#   count = 2
# }

#commented code needs to be fixed
