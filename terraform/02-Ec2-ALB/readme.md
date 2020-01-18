### Create Infra Stack on AWS
Provision the below AWS environment using terraform scripts

* Step-1, Provision VPC, Subnets, Gateways.
* Step-2, Provision Subnet-A (Jumbox-CIDR) and Attach Bastion-Security Groups from external network.
* Step-3, Provision Subnet-B (Jenkins-Master-CIDR) and Attach access from Bastion-CIDR only.
* Step-4, Provision Subnet-C (Jenkins-Slave-CIDR) and Attach access from/to Jenkins-Master-CIDR only.


* Step-2, Provision AWS load balancer AutoScaling Group, EC2 instances using terraform scripts
* Step-3, Provision ALB, Listeners, Target Group and Attach to AutoScaling Group

### Validate and Format commands
```
terraform validate
terraform fmt
```
### Initialize with s3 bucket
```
bucket_env=test/master-ec2alb
region_name=us-east-2
bucket_name=vk-enterprise-jenkins-infra-bckt
bucket_key=jenkins-master/${bucket_env}/terraform.tfstate

terraform init -backend-config="bucket=${bucket_name}" -backend-config="key=${bucket_key}" -backend-config="region=${region_name}"
```

### plan/apply/destroy with variables file

```
terraform plan --var-file=jenkins-master/terraform.tfvars
terraform apply --var-file=jenkins-master/terraform.tfvars
terraform destroy --var-file=jenkins-master/terraform.tfvars
```

### Query for output variables
```
terraform output load_balancer_name
```