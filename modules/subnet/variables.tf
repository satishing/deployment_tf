variable "vpc_id" {
    description = "VPI ID"
    type        = string
}

variable "zones" {
    description = "List of availability zones"
    type        = list
    default     = []
}

variable "cidr" {
    description = "Base CIDR block which will be divided into subnet CIDR blocks"
    type        = string
}

variable "subnet_bits_default" {
    description = "Subnet bits default"
    type        = string
}
variable "subnet_bits_private" {
    description = "Subnet bits for private subnet"
    type        = string
}


variable "priv_name" {
    description = "Name for private subnet"
    type        = string
}
variable "priv_subnet_start" {}

variable "pub_name" {
    description = "Name for public subnet"
    type        = string
}
variable "pub_subnet_start" {}

variable "tags" {
    description = "Resource Tags"
    type        = map(string)
    default     = {}
}
