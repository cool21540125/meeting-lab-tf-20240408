variable "vpc_cidr" {
  default = "10.40.0.0/16"
}

variable "tag_name_prefix" {
  default     = "meeting-lab"
  description = "Used to prefix the name of resource"
}

variable "network_config_path" {
  type        = string
  description = "Config file path for networking"
  default     = ""
}

locals {
  public_subnets  = yamldecode(file("${var.network_config_path}"))["subnets"]["public"]
  private_subnets = yamldecode(file("${var.network_config_path}"))["subnets"]["private"]
}
