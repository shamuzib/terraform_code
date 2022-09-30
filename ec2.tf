resource "aws_instance" "prod-ec2-web" {
  ami           = var.ami_type
  instance_type = var.ec2_type
  associate_public_ip_address = true
  availability_zone = var.availability_zone
  security_groups = xxxxxxxxxxxxxxxxxxxxxxxxxxxxx # Create and setup a SG for Webtier EC2
  tags          = local.common_tags
}
