data "aws_availability_zones" "prod-az" {
  state = "available"
}

# data "aws_instance" "ec2_list" {
#   instance_id = flatten(aws_instance.prod-ec2-private[*].id)
# }
