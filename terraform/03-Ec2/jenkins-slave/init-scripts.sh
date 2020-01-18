#!/bin/bash

start_slaveservice() {
    sleep 10
    /bin/nohup /var/jenkins/ec2_startup_init_script.sh
}

main() {
    start_slaveservice
}

main
