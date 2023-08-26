#Variable for region
variable "aws_region" {
  default = "eu-west-2"
}

#Variable for vpc cidr range
variable "vpc_cidr" {
  type = string
  default = ""
}

#Public Route Propagation
variable "routes_public" {
  default = ""
}

#AMI Type for EC2
variable "ami_type" {
  default = ""
}

#EC2 Instance Type
variable "ec2_instance" {
  default = "t2.nano"
}

#Variable for Public availability_zone
variable "az_public" {
  type    = list(string)
  default = []
}

#Variable for Private availability_zone
variable "az-private" {
  type    = list(string)
  default = []
}

















#Subnet's CIDR range, values defined in terraform.tfvars file
variable "subnet_cidr_public" {
  type    = list(any)
  default = []
}
#private CDIR list, values defined in terraform.tfvars file
variable "subnet_cidr_private" {
  type    = list(any)
  default = []
}

# # Number of Internet gateways
# variable "natgw_count" {
#   default = 1
# }



variable "max_subnets" {
  default     = "6"
  description = "Maximum number of subnets that can be created. The variable is used for CIDR blocks calculation"
}

variable "ec2_type" {
  default = ""
}



# variable "vpn_ip" {
#   default = "0.0.0.0/32"
# }
#
# variable "sg_ports" {
#   type = list(number)
#   default = [22,98,8033,9800]
# }
#
# variable "ec2_instance" {
#   type = map
#   default = {
#     eu-west-1 = "t2.micro"
#     eu-west-2 = "t2.nano"
#     eu-west-3 = "t2.small"
#    }
# }
#
# variable "ec2_instance1" {
#   type = list
#   default = ["t2.micro","t2.nano","t2.small"]
# }
#
# variable "istest" {
#   default = true
# }
#
# variable "iam_lb" {
#   type    = list(any)
#   default = ["prod-1", "prod-2", "prod-3"]
# }
#
# variable "iam_lb_name" {
#   type    = list(any)
#   default = ["user-1", "user-2", "user-3"]
# }
#
# variable "iamuser" {
#   type = number
# }
#
# variable "az" {
#   type = list
# }

# variable "username" {
#   type    = list(string)
#   default = ["l1", "l2", "l3"]
# }


# variable "vpn_ip" {
# /*  default = "0.0.0.0/32" */
# }
