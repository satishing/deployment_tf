resource "aws_db_subnet_group" "this" {
  subnet_ids  = var.subnet_ids
  name        = "${var.name}-db-subnet-group"

  tags = merge(
    map(
      "Name", "${var.name}-db-subnet-group",
    ),var.tags,
  )
}