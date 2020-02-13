variable "allocated_storage" {
    description = "The allocated storage in gibibytes."
    default = 20
}
variable "storage_type" {
    description = "The storage type of RDS instance."
    default = "gp2"
}       
variable "engine" {
    description = "The database engine to use."
    default = "mysql"
}              
variable "engine_version" {
    description = "The engine version to use."
    default = "5.7"
}      
variable "instance_class" {
    description = "db.t2.micro"
    default = "The instance type of RDS instance."
}
variable "identifier" {
    description = "The identifier of RDS instance."
    default = "msqldb"
}       
variable "name" {
    description = "The name of RDS instance."
    default = "msqldb"
}                
variable "username" {
    description = "Username of RDS."
    default = "admin"
}            
variable "password"  {
    description = "Password of RDS."
    default = "somestrongpassword"
}           
variable "parameter_group_name" {
    description = "Parameter goup of RDS instance"
    default = "default.mysql5.7"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "Name of final snapshot to be taken."
}

variable "tags" {
    description = "Resource Tags"
    type        = map(string)
    default     = {}
}
