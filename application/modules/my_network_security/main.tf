### ============ Network Access ============

## Security Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

## Security Group
resource "aws_security_group" "my_sg" {
  name        = "${var.tag_name_prefix}-${var.sg_usage}"
  description = "${var.tag_name_prefix}-${var.sg_usage}"
  vpc_id      = var.vpc_id

  tags = {
    Usage = var.sg_usage
  }
}

## Security Group - Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "my_sg_ingress" {
  security_group_id = aws_security_group.my_sg.id

  for_each    = var.sg_ingress_rules.ingress
  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port

  referenced_security_group_id = each.value.referenced_security_group_id
}

## Security Group - Egress Rule (Allow ALL)
resource "aws_vpc_security_group_egress_rule" "my_sg_egress" {
  security_group_id = aws_security_group.my_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = -1
  to_port     = -1
}
