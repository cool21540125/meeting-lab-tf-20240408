variable "tag_name_prefix" {
  default     = "meeting-lab"
  description = "Used to prefix the name of resource"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "dmz_sg_ingress_rules" {
  description = "The security group rules for the web servers."
  type = object({
    ingress = map(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    }))
  })
}
