#Region and availability_zone
aws_region = "eu-west-2"
az_public  = ["eu-west-2a", "eu-west-2b"]
az-private = ["eu-west-2a", "eu-west-2b"]
#CID for VPC and subnets
vpc_cidr            = "10.0.0.0/16"
subnet_cidr_public  = ["10.0.0.0/20", "10.0.16.0/20"]
subnet_cidr_private = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", "10.0.176.0/20"]
#Route Table Propagations
routes_public = "0.0.0.0/0"
#Instance Types
ec2_type = "t2.micro"
ami_type = "ami-06672d07f62285d1d"
