#!/bin/bash

### UBUNTU server
install_prerequisites(){
    sudo apt-get update
    sudo apt-get install wget unzip -y
}

increase_memory_limits(){
    sudo sysctl vm.max_map_count
    sudo sysctl fs.file-max
    sudo ulimit -n
    sudo ulimit -u
}

install_java11(){
    sudo apt install openjdk-11-jre-headless -y
    sudo apt install openjdk-11-jdk-headless -y
}

install_java8(){
    sudo apt install openjdk-8-jre-headless -y
    sudo apt install openjdk-8-jdk-headless -y
}

install_sonarqube(){
    SONAR_LOCATION=/var/lib/sonarqube
    sudo rm -rf ${SONAR_LOCATION}
    sudo mkdir -p ${SONAR_LOCATION}
    cd /tmp 
    sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.6.zip
    sudo unzip sonarqube-7.6.zip
    sudo mv sonarqube-7.6 ${SONAR_LOCATION}
    sudo mv ${SONAR_LOCATION}/sonarqube-7.6/* ${SONAR_LOCATION}/
    sudo rm -rf sonarqube-7.6.zip
    cd ${SONAR_LOCATION}
    sudo chmod 777 -R ${SONAR_LOCATION}

    sh /var/lib/sonarqube/bin/linux-x86-64/sonar.sh status
    # Check status
}

main(){
    install_prerequisites

    install_java11

    install_sonarqube
}

main