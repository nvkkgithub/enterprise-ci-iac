#!/bin/bash

/bin/nohup java -Duser.home=/var/jenkins -Djenkins.model.Jenkins.slaveAgentPort=5000 -jar /var/jenkins/startup/jenkins.war & >> /dev/null 2>&1