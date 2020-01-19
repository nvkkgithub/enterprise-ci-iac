#!/bin/bash

start_jenkins() {
    sleep 5
    sudo -u ec2-user sh /var/jenkins/startup/jenkins_start.sh
}

main() {
    start_jenkins
}

main
