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

#DB Admin Username
variable "user_name" {
  type    = string
}

#DB Admin Password
variable "password" {
  type    = string
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

variable "max_subnets" {
  default     = "6"
  description = "Maximum number of subnets that can be created. The variable is used for CIDR blocks calculation"
}

variable "ec2_type" {
  default = ""
}
