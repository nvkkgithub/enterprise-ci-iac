jenkins-master-ami/create: ## Create Jenkins Master AMI
	@echo "Creating the packer"
	@cd 02-Ec2-ALB && terraform apply --var-file=jenkins-master/terraform.tfvars

jenkins-master-ami/create: ## Create Jenkins Slave AMI
	@echo "Creating Jenkins Slave AMI"
	@bucket_env=test/master-ec2alb
	@region_name=us-east-2
	@bucket_name=vk-enterprise-jenkins-infra-bckt
	@bucket_key=jenkins-master/${bucket_env}/terraform.tfstate
	@cd 02-Ec2-ALB && terraform init
	@cd 02-Ec2-ALB && terraform destroy --var-file=jenkins-master/terraform.tfvars
