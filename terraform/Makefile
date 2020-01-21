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
	@cd 02-Ec2-ALB && terraform destroy --var-file=jenkins-master/terraform.tfvars --auto-approve

jenkins-slave/create: ## Create Jenkins Slave
	@echo "Creating Jenkins Slave and Auto Attach to Jenkins Master"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform apply --var-file=jenkins-slave/terraform.tfvars --auto-approve

jenkins-slave/destroy: ## Create Jenkins Slave
	@echo "Destroying Jenkins Slave"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform destroy --var-file=jenkins-slave/terraform.tfvars --auto-approve

bastion-server/create: ## Create Bastion Server
	@echo "Destroying Jenkins Slave"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform apply --var-file=bastion-server/terraform.tfvars

bastion-server/destroy: ## Destroy Bastion Server
	@echo "Destroying Jenkins Slave"
	@cd 03-Ec2 && terraform init
	@cd 03-Ec2 && terraform destroy --var-file=bastion-server/terraform.tfvars

sonar-server/create:
	@echo "Creating SONAR and ELK Server"
	@cd 03-Ec2/sonar-server && terraform init
	@cd 03-Ec2/sonar-server && terraform apply --auto-approve

sonar-server/destroy:
	@echo "Destroying SONAR and ELK Server"
	@cd 03-Ec2/sonar-server && terraform init
	@cd 03-Ec2/sonar-server && terraform destroy --auto-approve