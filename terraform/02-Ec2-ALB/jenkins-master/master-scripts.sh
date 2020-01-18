#!/bin/bash

start_jenkins() {
    sleep 10
    #sudo -u ec2-user /bin/nohup /usr/lib/tomcat/bin/startup.sh
    sudo systemctl start tomcat
}

main() {
    start_jenkins
}

main
