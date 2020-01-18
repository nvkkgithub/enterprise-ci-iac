#!/bin/bash

export JENKINS_SLAVE_EXEC_COUNT=2
export JENKINS_SLAVE_LABEL=rhel-jenkins-slave

sh /var/jenkins/cli_createnode_n_connect.sh ${JENKINS_SLAVE_EXEC_COUNT} ${JENKINS_SLAVE_LABEL}