jenkins-master-ami/create:
	@cd packer && make jenkins-master-ami/create

jenkins-slave-ami/create:
	@echo "*** TODO **** User packer build command directly from 'packer' folder."
	@cd packer && make jenkins-slave-ami/create

jenkins-master/create: ## Create Jenkins Master
	@cd terraform && make jenkins-master/create

jenkins-master/destroy: ## Destroy Jenkins Master
	@cd terraform && make jenkins-master/destroy

jenkins-slave/create: ## Create Jenkins Slave
	@cd terraform && make jenkins-slave/create

jenkins-slave/destroy: ## Destroy Jenkins Slave
	@cd terraform && make jenkins-slave/destroy

bastion-server/create: ## Destroy Jenkins Slave
	@cd terraform && make bastion-server/create

bastion-server/destroy: ## Destroy Bastion Server
	@cd terraform && make bastion-server/destroy

sonar-server/create: ## Create Sonar n ELK server
	@cd terraform && make sonar-server/create

sonar-server/destroy: ## Destroy Sonar n ELK server
	@cd terraform && make sonar-server/destroy