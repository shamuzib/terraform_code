# terraform_code
This is Terraform code to spin up AWS three tier architecture

You can override variable defaults by directly mentioning it fro command line
ex - var.ec2_instance is having default t2.nano. If you run terraform apply -var="instancetype=m2.large", then cmd values will override variable defaults and spin up m2.large instance
