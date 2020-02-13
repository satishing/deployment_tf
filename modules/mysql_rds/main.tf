resource "aws_db_instance" "this" {
  identifier           = var.name
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  deletion_protection  = true
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  final_snapshot_identifier = "${var.name}-db-instance-snapshot"

  tags = merge(
    map(
      "Name", "${var.name}-db-instance",
    ),var.tags
  )
}