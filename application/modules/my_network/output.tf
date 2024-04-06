output "out_public_subnets_cidr" {
  value = [for s in aws_subnet.my_public_subnets : s.cidr_block]
}

output "out_private_subnets_cidr" {
  value = [for s in aws_subnet.my_private_subnets : s.cidr_block]
}

output "out_vpc_id" {
  value = aws_vpc.my_vpc.id
}
