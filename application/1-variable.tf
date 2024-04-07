
variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "tag_name_prefix" {
  type        = string
  description = "Used to prefix the name of resource"
  default     = "meeting-lab"
}
variable "tag_name_suffix" {
  type        = string
  description = "Used to make additional notes on resource"
  default     = ""
}

variable "my_ip" {
  type    = string
  default = ""
}

variable "public_key" {
  type        = string
  description = "Used to ssh to host"
  default     = "<Your public key>"
}

locals {
  dmz_sg_ingress_rules = {
    ingress = {
      "http-public-subnet" = {
        cidr_ipv4   = "${var.my_ip}/32"
        ip_protocol = "tcp"
        from_port   = 80
        to_port     = 80
      }
      "https-public-subnet" = {
        cidr_ipv4   = "${var.my_ip}/32"
        ip_protocol = "tcp"
        from_port   = 443
        to_port     = 443
      }
      "ssh-public-subnet" = {
        cidr_ipv4   = "${var.my_ip}/32"
        ip_protocol = "tcp"
        from_port   = 22
        to_port     = 22
      }
    }
  }
  private_sg_ingress_rules = {
    ingress = {
      "from-dmz-sg" = {
        referenced_security_group_id = module.my_dmz_sg.out_security_group.id
        ip_protocol                  = "tcp"
        from_port                    = 22
        to_port                      = 22
      }
    }
  }
}
