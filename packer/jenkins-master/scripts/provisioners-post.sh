#!/bin/bash

install_java8(){
    JDK_PACKAGE_NAME=java-1.8.0-openjdk-devel
    sudo yum -y install ${JDK_PACKAGE_NAME}
}

install_jenkins_via_tomcat(){
    CATALINA_HOME=/usr/lib/tomcat
    SUDO_USER_NAME=ec2-user
    tomcat_tmp_dir=/tmp/tomcat
    tomcat_dist_url=https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz
    jenkins_dist_url=http://mirrors.jenkins.io/war-stable/latest/jenkins.war
    REMOTE_FILES_FOLDER=/tmp/remotefiles
    TOMCAT_SERV_FILE_NAME=tomcat.service
    USER_PROFILE=/home/${SUDO_USER_NAME}/.bashrc
    SYSTEM_D=/etc/systemd/system

    sudo rm -rf ${CATALINA_HOME}
    sudo rm -rf ${tomcat_tmp_dir}
    sudo mkdir ${CATALINA_HOME}
    sudo mkdir ${tomcat_tmp_dir}
    cd ${tomcat_tmp_dir}
    sudo wget ${tomcat_dist_url}
    sudo wget ${jenkins_dist_url}
    sleep 5
    sudo tar -zxf *.tar.gz
    sleep 10
    sudo mv ${tomcat_tmp_dir}/apache*/* ${CATALINA_HOME}/
    sudo mv ${tomcat_tmp_dir}/jenkins.war ${CATALINA_HOME}/webapps/
    cd ..
    sudo rm -rf ${tomcat_tmp_dir}
    sudo chmod -R 777 ${CATALINA_HOME}/
    sudo echo CATALINA_HOME=${CATALINA_HOME} >> ${USER_PROFILE}
    sudo chown -R ${SUDO_USER_NAME}:${SUDO_USER_NAME} ${CATALINA_HOME}/
    sudo cp -rf ${REMOTE_FILES_FOLDER}/${TOMCAT_SERV_FILE_NAME} ${SYSTEM_D}/
    sudo chmod 0777 ${SYSTEM_D}/${TOMCAT_SERV_FILE_NAME}
    sleep 10
    sudo chkconfig tomcat on

    echo '**** COMPLETED: Installing Jenkins *****'
}

identify_admin_password() {
    SUDO_USER_NAME=ec2-user
    sudo systemctl start tomcat
    #sudo -u ${SUDO_USER_NAME} /bin/nohup /usr/lib/tomcat/bin/startup.sh
    sleep 15
    echo '****** CALLING Jenkins URL *******'
    curl http://localhost:8080/jenkins
    sleep 10
    echo '*********** Jenkins - Admin password ********** ' + ${SUDO_USER_NAME}
    cat /home/${SUDO_USER_NAME}/.jenkins/secrets/initialAdminPassword
    
    sudo chkconfig tomcat off
    echo '**** COMPLETED: Initializing Admin password *****'
}

main(){
    install_java8

    install_jenkins_via_tomcat

    identify_admin_password

}

main