variable "tag_name_prefix" {
  default     = "meeting-lab"
  description = "Used to prefix the name of resource"
}

variable "vpc_id" {
  type    = string
  default = ""
}

# https://blog.avangards.io/5-tips-to-efficiently-manage-aws-security-groups-using-terraform
variable "sg_ingress_rules" {
  description = "The security group rules for the web servers."
  type = object({
    ingress = map(object({
      cidr_ipv4                    = optional(string)
      from_port                    = optional(number)
      ip_protocol                  = optional(string)
      to_port                      = optional(number)
      referenced_security_group_id = optional(string)
    }))
  })
}

variable "sg_usage" {
  type        = string
  description = "this security group is used from"
  default     = ""
}
