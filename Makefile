jenkins-master/create: ## Create Jenkins Master
	@cd terraform && make jenkins-master/create

jenkins-master/destroy: ## Create Jenkins Master
	@cd terraform && make jenkins-master/destroy

jenkins-slave/create: ## Create Jenkins Slave
	@cd terraform && make jenkins-slave/create

jenkins-slave/destroy: ## Create Jenkins Master
	@cd terraform && make jenkins-slave/destroy

