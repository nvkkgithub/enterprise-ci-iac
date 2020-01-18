## Enterprise CI using Infrastructure As Code
This repository contains code to provision infrastructure on AWS cloud for Enterprise CI platform.

This repository uses below two Hashicorp tools
* Packer - for creating AMIs with required softwares (Java, Maven, Jenkins..etc) as needed for Jenkins Master and Slave. 
** For more details refer to "/packer/readme.md" folder.

* Terraform - to provision different types of infrastrcuture individually i.e., 'Infrastack', 'EC2-ALB-stack', 'EC2'. This will enable reusability.
** For more infromation refer


### AWS - Deployment Architecture
![Enterprise-CI AWS deployment architecture](EnterpriseCI-AWS-Deployment-Architecture.jpg)

### Usage

#### Packer - Create AMI 

##### Assumptions:
* AWS IAM role created with access to VPC - full access, EC2 - full acess and <access-key> and * Access details i.e., 'access-key' and 'secret-key' details will be passed as parameters to create command.

```
cd packer
make jenkins/master -aws_access_key=<access-key> -aws_secret_key=<secret-key>
make jenkins/slave -aws_access_key=<access-key> -aws_secret_key=<secret-key>

```

### Terraform - Provision Infrastructure

##### Assumptions:
* AWS IAM role created with access to VPC-FullAccess, EC2-FullAccess, S3-Read/Write access. 
* Access details i.e., 'access-key' and 'secret-key' details will be passed as parameters to create command.

```
cd terraform
make jenkins-master/infra-stack -aws_access_key=<access-key> -aws_secret_key=<secret-key>
make jenkins-master/ec2-provision -aws_access_key=<access-key> -aws_secret_key=<secret-key>
make jenkins-slave/ec2-provision -aws_access_key=<access-key> -aws_secret_key=<secret-key>
make bastion-host/provision -aws_access_key=<access-key> -aws_secret_key=<secret-key>
```

