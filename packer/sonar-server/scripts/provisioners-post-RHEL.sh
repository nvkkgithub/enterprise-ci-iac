#!/bin/bash

### RHEL server
install_prerequisites(){
    sudo yum update -y
    sudo yum install wget unzip -y
    sudo yum install java-11-openjdk-devel -y
    sudo sysctl vm.max_map_count
    sudo sysctl fs.file-max
    sudo ulimit -n
    sudo ulimit -u
}


install_sonarqube(){
    SONAR_LOCATION=/var/lib/sonarqube
    sudo rm -rf ${SONAR_LOCATION}
    sudo mkdir -p ${SONAR_LOCATION}
    cd /tmp 
    sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.6.zip
    sudo unzip sonarqube-7.6.zip
    sudo mv sonarqube-7.6 ${SONAR_LOCATION}
    sudo rm -rf sonarqube-7.6.zip
    cd ${SONAR_LOCATION}
}

main(){
    install_prerequisites

    install_sonarqube
}

main