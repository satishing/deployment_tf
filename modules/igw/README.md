```
module "aws_internet_gateway" {
  source = "./modules/igw"
  
  pub_name              = var.vpc_id
  name                  = var.name
  tags                  = var.tags       
}
```