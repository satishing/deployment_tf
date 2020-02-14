

#### Assumptions:
1. AWS key-pair pem file is created.
2. Below variables are set with correct values, Use set instead of export in case of Windows.
```
$ export AWS_ACCESS_KEY_ID="awsaccesskeyid"
$ export AWS_SECRET_ACCESS_KEY="awssecretaccesskey"
$ export AWS_DEFAULT_REGION="eu-west-2"
$ export TF_VAR_username="admin"
$ export TF_VAR_password="strongpassword"
```
3. Minimum terraform version v0.12.9 is installed.

#### How to run this IaC?
1. Clone this repository and place pem file at same location. 
2. Make sure to have correct permissions to this key file (Run chmod 400 <pem-file-name>))
3. Run following commands to create infrastructure
```
$ terraform init
$ terraform plan -var-file=dev.tfvars
$ terraform apply -dev-tfvars=dev.tfvars --auto-approve
```
4. Run following commands to destroy infrastructure

```
$ terraform destroy -dev-tfvars=dev.tfvars --auto-approve
```
