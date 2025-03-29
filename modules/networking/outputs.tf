output "vpc_id" {
  value       = aws_vpc.prod_vpc.id
  description = "Output of VPC ID"
}

output "public_subnets" {
  value       = aws_subnet.public_subnet.*.id
  description = "Public Subnets"
}

output "public_subnet_cidr_block" {
  value       = aws_subnet.public_subnet.*.cidr_block
  description = "Public Subnet CIDR Block"
}
