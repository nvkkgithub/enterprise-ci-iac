#!/bin/bash

install_java8(){
    JDK_PACKAGE_NAME=java-1.8.0-openjdk-devel
    sudo yum -y install ${JDK_PACKAGE_NAME}
}

install_maven_3_6(){
    REMOTE_FILES_FOLDER=/tmp/remotefiles
    MAVEN_TEMP_LOCATION=/tmp/repofiles/maven
    MAVEN_HOME=/usr/lib/maven/maven36
    MAVEN_DISTR_URL=https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    sudo mkdir -p ${MAVEN_HOME}
    sudo mkdir -p ${MAVEN_TEMP_LOCATION}
    sudo wget ${MAVEN_DISTR_URL} -P ${MAVEN_TEMP_LOCATION}/
    cd ${MAVEN_TEMP_LOCATION}/ && sudo tar -xf apache-maven-*.gz
    sudo mkdir /usr/lib/maven
    sudo mv ${MAVEN_TEMP_LOCATION}/apache-maven-*/* ${MAVEN_HOME}/
    cd /tmp/repofiles/
    sudo rm -rf ${MAVEN_TEMP_LOCATION}
} 

init_connect_slave_as_a_service(){
    export JENKINS_SLAVE_SERVICE=jenkinsslave.service
    export REMOTE_FILES_FOLDER=/tmp/remotefiles
    export SUDO_USER_NAME=ec2-user
    export SLAVE_JENKINS_DIR=/var/jenkins
    sudo mkdir -p ${SLAVE_JENKINS_DIR}
    sudo cp -rf ${REMOTE_FILES_FOLDER}/cli_createnode_n_connect.sh ${SLAVE_JENKINS_DIR}/
    sudo cp -rf ${REMOTE_FILES_FOLDER}/slave-agent-register.sh ${SLAVE_JENKINS_DIR}/
    sudo cp -rf ${REMOTE_FILES_FOLDER}/ec2_startup_init_script.sh ${SLAVE_JENKINS_DIR}/
    sudo cp -rf ${REMOTE_FILES_FOLDER}/${JENKINS_SLAVE_SERVICE} /etc/systemd/system/
    sudo rm -rf ${REMOTE_FILES_FOLDER}
    sudo chmod -R 777 ${SLAVE_JENKINS_DIR}
    sudo chown -R ${SUDO_USER_NAME}:${SUDO_USER_NAME} ${SLAVE_JENKINS_DIR}/
    cd ${SLAVE_JENKINS_DIR}
    sed -i 's/\r$//' *.sh
    sudo systemctl daemon-reload
    sudo systemctl enable ${JENKINS_SLAVE_SERVICE}
}

main(){
    install_java8

    install_maven_3_6

    init_connect_slave_as_a_service

}

main