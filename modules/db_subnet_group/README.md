```
module "aws_db_subnet_group" {
  source = "./modules/aws_db_subnet_group"

  name       = var.name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}
```
