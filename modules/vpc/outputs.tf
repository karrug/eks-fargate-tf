output "subnet_ids" {
  value = [
    aws_subnet.public_subnet_one.id,
    aws_subnet.public_subnet_two.id,
    aws_subnet.private_subnet_one.id,
    aws_subnet.private_subnet_two.id,
  ]
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_one.id,
    aws_subnet.public_subnet_two.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_one.id,
    aws_subnet.private_subnet_two.id
  ]
}
