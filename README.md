# terraform_code
This is Terraform code to spin up AWS three tier architecture (Currently it's upto 2-tier architecture)

You can override variable defaults by directly mentioning it fro command line

ex - var.ec2_instance is having default t2.nano. If you run terraform apply -var="<variable_name>=m2.large", then cmd values will override variable defaults and spin up m2.large instance

If you don't define any default values in varaible block, then it will prompt for the input
