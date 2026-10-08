locals {
  subnet = merge([
    for spoke_key, spoke in var.spokes : {
      for subnet_key, subnet in spoke :
      "${spoke_key}-${subnet_key}" => {
        subnet_name = subnet.subnet_name
        subnet_cidr = subnet.subnet_cidr
        subnet_key  = subnet_key
      }
    }
  ]...)
}