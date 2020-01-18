#!/bin/bash
export SLAVE_MOUNT_DIR=/var/jenkins/rhelslave
export SLAVE_STARTUP_LOG=/var/jenkins/slave_startup.log

register_slave() {
    sudo chmod -R 777 ${SLAVE_MOUNT_DIR}/
    sudo rm -rf ${SLAVE_STARTUP_LOG}
    sudo -u ec2-user /var/jenkins/slave-agent-register.sh > ${SLAVE_STARTUP_LOG} 2>&1 &
}

clean_temp_files() {
    sudo rm -rf /var/jenkins/agent.jar.*
    sudo rm -rf /var/jenkins/wget-log.*
}

main() {
    
    _SLAVE_PID=`ps -ef | grep java | grep "agent.jar" | awk '{print $2}'`

    if [[ -z "$_SLAVE_PID" ]]; then
        register_slave
    else
        echo "**** NOT STARTING JOB ******" >> ${SLAVE_STARTUP_LOG}    
    fi

    clean_temp_files
}

main


