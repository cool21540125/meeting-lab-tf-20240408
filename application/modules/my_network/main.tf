### ============ Networking ============

## VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.tag_name_prefix}-vpc"
  }
}


### Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.tag_name_prefix}-igw"
  }
}


## Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

## Public Subnet
resource "aws_subnet" "my_public_subnets" {
  for_each = { for s in local.public_subnets : s.name => s }

  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = each.value.zone
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.name
  }

  depends_on = [aws_vpc.my_vpc]
}
## private subnet
resource "aws_subnet" "my_private_subnets" {
  for_each = { for s in local.private_subnets : s.name => s }

  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = each.value.zone
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false

  tags = {
    Name = each.value.name
  }

  depends_on = [aws_vpc.my_vpc]
}


### Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

## public route table
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "${var.tag_name_prefix}-public-rt"
  }
}
resource "aws_route_table_association" "my_public_rt_association" {
  for_each = aws_subnet.my_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.my_public_rt.id
}

# ## private route table
resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.tag_name_prefix}-private-rt"
  }
}
resource "aws_route_table_association" "my_private_rt_association" {
  for_each = aws_subnet.my_private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.my_private_rt.id
}
