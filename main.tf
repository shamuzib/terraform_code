terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.32.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "prod-s3-tf-backend"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
