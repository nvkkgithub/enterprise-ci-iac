jenkins-master/create: ## Create Jenkins Master
	@echo "Creating the Jenkins Master and Attach to ALB"
	@bucket_env=test/master-ec2alb
	@region_name=us-east-2
	@bucket_name=vk-enterprise-jenkins-infra-bckt
	@bucket_key=jenkins-master/${bucket_env}/terraform.tfstate
	@cd 02-Ec2-ALB && terraform init
	@cd 02-Ec2-ALB && terraform apply --var-file=jenkins-master/terraform.tfvars

jenkins-master/destroy: ## Destroy Jenkins Master
	@echo "Destroying the Jenkins Master and Detaching from ALB"
	@bucket_env=test/master-ec2alb
	@region_name=us-east-2
	@bucket_name=vk-enterprise-jenkins-infra-bckt
	@bucket_key=jenkins-master/${bucket_env}/terraform.tfstate
	@cd 02-Ec2-ALB && terraform init
	@cd 02-Ec2-ALB && terraform destroy --var-file=jenkins-master/terraform.tfvars

jenkins-slave/create: ## Create Jenkins Slave
	@echo "Creating Jenkins Slave and Auto Attach to Jenkins Master"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform apply --var-file=jenkins-slave/terraform.tfvars --auto-approve

jenkins-slave/destroy: ## Create Jenkins Slave
	@echo "Destroying Jenkins Slave"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform destroy --var-file=jenkins-slave/terraform.tfvars --auto-approve

