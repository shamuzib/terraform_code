resource "aws_internet_gateway" "prod-igw" {
  tags = {
    env = "production"
  }
}

resource "aws_internet_gateway_attachment" "prod-vpc-igw" {
  internet_gateway_id = aws_internet_gateway.prod-igw.id
  vpc_id = aws_vpc.prod-vpc.id
}
