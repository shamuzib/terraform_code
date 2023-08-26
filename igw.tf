#Create Internet Gateway
resource "aws_internet_gateway" "prod-igw" {
  tags = local.common_tags
}

#Associating IGW to VPC created
resource "aws_internet_gateway_attachment" "prod-vpc-igw" {
  internet_gateway_id = aws_internet_gateway.prod-igw.id
  vpc_id              = aws_vpc.prod-vpc.id
}
