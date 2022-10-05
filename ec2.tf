#Private Instances
resource "aws_instance" "prod-ec2-private" {
  ami                         = var.ami_type
  instance_type               = var.ec2_type
  # availability_zone = data.aws_availability_zones.test-az.names[count.index]
  availability_zone = var.az_public != "" ? var.az_public[count.index % length(var.az_public)] : var.az-private[count.index % length(var.az-private)]
  security_groups   = [aws_security_group.prod_alb_private_sg.id]
  subnet_id         = aws_subnet.prod-subnet-private[count.index].id
  tags              = local.common_tags
  count             = 2
  user_data         = file("${path.module}/userdata.sh")
  key_name          = "project-dec"
}
#Public Jump Host for connection
resource "aws_instance" "prod-ec2-jumphost-public" {
  ami                         = var.ami_type
  instance_type               = var.ec2_type
  associate_public_ip_address = true
  availability_zone = var.az_public != "" ? var.az_public[count.index % length(var.az_public)] : var.az-private[count.index % length(var.az-private)]
  security_groups   = [aws_security_group.prod_alb_pub_sg.id]
  subnet_id         = aws_subnet.prod-subnet-public[count.index].id
  tags              = local.common_tags
  count             = 1
  key_name          = "project-dec"
}
