# Create a Route a Public Routes
resource "aws_route_table" "prod-rt-public" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = var.routes_public
    gateway_id = aws_internet_gateway.prod-igw.id
  }
  tags = local.common_tags
}

#Associate Route table with Public subnet
resource "aws_route_table_association" "prod-public-routes" {
  subnet_id      = element(aws_subnet.prod-subnet-public[*].id, count.index)
  route_table_id = aws_route_table.prod-rt-public.id
  count          = 2
}

# Create a Route a Public Routes
resource "aws_route_table" "prod-rt-private" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = var.routes_public
    gateway_id = element(aws_nat_gateway.prod-natgw[*].id, 0)
  }
  tags = local.common_tags
}

#Associate Route table with Private subnet
resource "aws_route_table_association" "prod-private-routes" {
  subnet_id      = element(aws_subnet.prod-subnet-private[*].id, count.index)
  route_table_id = aws_route_table.prod-rt-private.id
  count          = 4
}
