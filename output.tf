output "subnet-names" {
  value = aws_subnet.prod-subnet-public[*].id
}

output "az-values" {
  value = data.aws_availability_zones.prod-az.names
}
