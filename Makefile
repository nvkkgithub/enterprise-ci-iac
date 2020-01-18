jenkins-master-ami/create:
	@echo "*** TODO **** User packer build command directly from 'packer' folder."

jenkins-slave-ami/create:
	@echo "*** TODO **** User packer build command directly from 'packer' folder."

jenkins-master/create: ## Create Jenkins Master
	@cd terraform && make jenkins-master/create

jenkins-master/destroy: ## Destroy Jenkins Master
	@cd terraform && make jenkins-master/destroy

jenkins-slave/create: ## Create Jenkins Slave
	@cd terraform && make jenkins-slave/create

jenkins-slave/destroy: ## Destroy Jenkins Slave
	@cd terraform && make jenkins-slave/destroy

