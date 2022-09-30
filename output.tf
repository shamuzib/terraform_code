output "subnet-names" {
  value = aws_subnet.prod-subnet-public[*].id
}
