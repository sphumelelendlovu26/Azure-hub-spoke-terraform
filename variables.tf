variable "location" {
  type = string
}
variable "hub_cidr" {
  type = string
}

variable "spokes" {
  type = map(object({
    spoke_name = string
    spoke_cidr = string
    subnet = map(object({
      subnet_name = string
      subnet_cidr = string
    }))
  }))
}

variable "hub_subnets" {
  type = map(object({
    subnet_name        = string
    subnet_cidr        = string
    subnet_description = string
  }))
}