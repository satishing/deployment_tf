team_name   = "brovitech"
owner       = "bharat"
environment = "prod"
prefix      = "brovitech"

# VPC
cidr = "172.20.0.0/16"

# Subnets
region                           = "eu-west-2"
zones                            = ["eu-west-2a", "eu-west-2b"]
subnet_partitioning_start_priv   = 10
subnet_partitioning_start_pub    = 20
subnet_partitioning_bits_private = 0
subnet_partitioning_bits_default = 8

# IGW
# NATGW
# RT

# Instance
ami                                  = "ami-006a0174c6c25ac06" //Ubuntu in London Region
instance_type                        = "t2.micro"
key_name                             = "brovitech_ec2_key"
monitoring                           = false
instance_initiated_shutdown_behavior = "stop"
tenancy                              = "default"

# DB
storage_type         = "gp2"
engine               = "mysql"
engine_version       = "5.7"
instance_class       = "db.t2.micro"
username             = "admin"
parameter_group_name ="default.mysql5.7"