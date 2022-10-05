#Security Group for public Load Balancer
resource "aws_security_group" "prod_alb_pub_sg" {
  name        = "prod_alb_pub_sg"
  description = "ALB SG - Internet Facing"
  vpc_id      = aws_vpc.prod-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.common_tags
}

#########################################
########Write Egress Rules for this######
#########################################

#Security Group for private Load Balancer
resource "aws_security_group" "prod_alb_private_sg" {
  name        = "prod_alb_private_sg"
  description = "ALB SG - Internal LB"
  vpc_id      = aws_vpc.prod-vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.prod_alb_pub_sg.id]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [aws_security_group.prod_alb_pub_sg.id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.prod_alb_pub_sg.id]
  }
  tags = local.common_tags
}
