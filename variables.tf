# TAGS
variable "team_name" {
  default = ""
}
variable "owner" {
  default = ""
}
variable "environment" {
  default = ""
}


# VPC
variable "prefix" {
  description = "Prefix to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource Tags"
  type        = map
  default     = {}
}

# Subnets
variable "zones" {
  description = "List of availability zones"
  type        = list
  default     = []
}

variable "subnet_partitioning_bits_private" {
  default = "2"
}

variable "subnet_partitioning_bits_default" {
  default = "4"
}

variable "region" {
}

variable "subnet_partitioning_start_priv" {
  default = "1"
}

variable "subnet_partitioning_start_pub" {
  default = "2"
}

# EC2
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "monitoring" {}
variable "instance_initiated_shutdown_behavior" {}
variable "tenancy" {}

# DB
variable "allocated_storage" {
  default = 20
}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.7"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "name" {
  default = "msqldb"
}
variable "username" {
  default = "admin"
}
variable "password" {
  default = "somestrongpassword"
}
variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "final_snapshot_identifier" {
  description = "Name of final snapshot to be taken."
  default = ""
}