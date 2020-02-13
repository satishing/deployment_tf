## EE Assignment

#### Assumptions:
1. AWS key-pair with name alpha_ec2_key is created.
2. Below variables are set with correct values, Use set instead of export in case of Windows.
```
$ export AWS_ACCESS_KEY_ID="awsaccesskeyid"
$ export AWS_SECRET_ACCESS_KEY="awssecretaccesskey"
```
3. Minimum terraform version v0.12.9 is installed.

#### How to run this IaC?
1. Clone this repository and place alpha_ec2_ke.pem file at same location. 
2. Make sure to have correct permissions to this key file (Run chmod 400 alpha_ec2_key.pem))
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
