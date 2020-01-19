### Create Infra Stack on AWS
Provision the EC2 instance and security groups

* Step-1, Create Security Groups
* Step-2, Provision EC2 instance by attaching the security groups

### Validate and Format commands
```
terraform validate
terraform fmt
terraform init
```
### Initialize with s3 bucket
```
bucket_env=test/slave-ec2
region_name=us-east-2
bucket_name=vk-enterprise-jenkins-infra-bckt
bucket_key=jenkins-master/${bucket_env}/terraform.tfstate

terraform init -backend-config="bucket=${bucket_name}" -backend-config="key=${bucket_key}" -backend-config="region=${region_name}"
```

### plan/apply/destroy with variables file

```
terraform plan --var-file=jenkins-slave/terraform.tfvars
terraform apply --var-file=jenkins-slave/terraform.tfvars
terraform destroy --var-file=jenkins-slave/terraform.tfvars
```
