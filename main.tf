locals {
  tags = {
    team        = var.team_name
    owner       = var.owner
    environment = var.environment
  }
}
# VPC
module "aws_vpc" {
  source               = "./modules/vpc"
  name                 = var.prefix
  cidr                 = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = local.tags
}

# Subnets
module "aws_subnet" {
  source              = "./modules/subnet"
  cidr                = var.cidr
  vpc_id              = module.aws_vpc.vpc_id
  zones               = var.zones
  subnet_bits_private = var.subnet_partitioning_bits_private
  subnet_bits_default = var.subnet_partitioning_bits_default
  priv_name           = "${var.prefix}-private"
  priv_subnet_start   = var.subnet_partitioning_start_priv
  pub_name            = "${var.prefix}-public"
  pub_subnet_start    = var.subnet_partitioning_start_pub
  tags                = local.tags
}

# IGW
module "aws_internet_gateway" {
  source = "./modules/igw"
  vpc_id = module.aws_vpc.vpc_id
  name   = var.prefix
  tags   = local.tags
}

# NATGW
module "aws_nat_gateway" {
  source           = "./modules/natgw"
  public_subnet_id = module.aws_subnet.public_subnets_id
  name             = var.prefix
  tags             = local.tags
}

# Route Tables
module "aws_route_table" {
  source         = "./modules/route_tables"
  vpc_id         = module.aws_vpc.vpc_id
  zones          = var.zones
  pub_name       = "${var.prefix}-public-subnet"
  priv_name      = "${var.prefix}-private-subnet"
  priv_subnets   = module.aws_subnet.priv_subnets
  pub_subnets    = module.aws_subnet.pub_subnets
  gateway_id     = module.aws_internet_gateway.igw_id
  nat_gateway_id = module.aws_nat_gateway.natgw_id
  tags           = local.tags
}

# Security group
module "aws_security_group" {
  source = "./modules/security_groups"
  name   = "${var.prefix}-nginx"
  vpc_id = module.aws_vpc.vpc_id
  tags   = local.tags
}

# Instance for nginx
module "aws_instance_nginx" {
  source                               = "./modules/ec2_instance"
  name                                 = "${var.prefix}-nginx"
  ami                                  = var.ami
  instance_type                        = var.instance_type
  user_data                            = "./deploy/nginx.sh"
  subnet_id                            = module.aws_subnet.public_subnets_id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  security_groups                      = [module.aws_security_group.sg_id]
  associate_public_ip_address          = true
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags                                 = local.tags
}

# Insance for node
module "aws_instance_node" {
  source                               = "./modules/ec2_instance"
  name                                 = "${var.prefix}-node"
  ami                                  = var.ami
  instance_type                        = var.instance_type
  user_data                            = "./deploy/node.sh"
  subnet_id                            = module.aws_subnet.private_subnets_id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  security_groups                      = [module.aws_security_group.sg_id]
  associate_public_ip_address          = false
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags                                 = local.tags
}

# DB subnet group
module "db_subnet_group" {
  source     = "./modules/db_subnet_group"
  name       = var.prefix
  subnet_ids = module.aws_subnet.priv_subnets
  tags       = local.tags
}
# Mysql DB instance
module "aws_rds_mysql" {
  source                    = "./modules/mysql_rds"
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  name                      = "${var.prefix}mysqldb"
  username                  = var.username
  password                  = var.password
  parameter_group_name      = var.parameter_group_name
  vpc_security_group_ids    = [module.aws_security_group.db_sg_id]
  db_subnet_group_name      = module.db_subnet_group.db_subnet_group_name
  final_snapshot_identifier = "${var.prefix}-db-instance-snapshot"
  tags                      = local.tags
}
