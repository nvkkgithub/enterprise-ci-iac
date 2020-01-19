#!/bin/bash

install_java8(){
    JDK_PACKAGE_NAME=java-1.8.0-openjdk-devel
    sudo yum -y install ${JDK_PACKAGE_NAME}
}

install_jenkins(){
    SUDO_USER_NAME=ec2-user
    jenkins_dist_url=http://mirrors.jenkins.io/war-stable/latest/jenkins.war
    JENKINS_HOME=/var/jenkins/startup
    sudo mkdir -p ${JENKINS_HOME}
    cd ${JENKINS_HOME}
    sudo wget ${jenkins_dist_url}
    sleep 5
    sudo chown -R ${SUDO_USER_NAME}:${SUDO_USER_NAME} ${JENKINS_HOME}/
    echo '**** COMPLETED: Installing Jenkins *****'
}

identify_admin_password() {
    SUDO_USER_NAME=ec2-user
    sudo -u ${SUDO_USER_NAME} sh /var/jenkins/startup/jenkins_start.sh
    # /bin/nohup java -Duser.home=/var/jenkins_home -Djenkins.model.Jenkins.slaveAgentPort=5000 -jar /var/jenkins/startup/jenkins.war --argumentsRealm.passwd.admin=fbvfp6D2cc --argumentsRealm.roles.admin=admin
    sleep 15
    echo '****** CALLING Jenkins URL *******'
    curl http://localhost:8080/
    sleep 10
    echo '*********** Jenkins - Admin password ********** ' + ${SUDO_USER_NAME}
    cat /home/${SUDO_USER_NAME}/.jenkins/secrets/initialAdminPassword
    echo '**** COMPLETED: Initializing Admin password *****'
}

main(){
    install_java8

    install_jenkins

    identify_admin_password

}

main