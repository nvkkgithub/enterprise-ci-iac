#!/bin/bash

export MASTER_BACK_UP_FOLDER=/tmp/jenkins-master-backup
export BACKUP_FILE_NAME=jenkins-master-backup.zip

restore_jenkins_from_s3(){
    # https://aws.amazon.com/getting-started/tutorials/backup-to-s3-cli/
    # aws configure
    # cross-check, aws_access_key_id & aws_secret_access_key updated in ~/.aws/credentials
    # cross-check, profile is updated in updated in ~/.aws/config

    rm -rf ${MASTER_BACK_UP_FOLDER}
    mkdir -p ${MASTER_BACK_UP_FOLDER}
    rm -rf ~/.jenkins_bak
    
    #aws s3 cp "s3://vk-test-jenkins-backup/jenkins-master-backup" ${MASTER_BACK_UP_FOLDER}/ --recursive

    cd ${MASTER_BACK_UP_FOLDER}
    aws s3 cp "s3://vk-test-jenkins-backup/jenkins-master-backup/${BACKUP_FILE_NAME}" ./
    unzip ${BACKUP_FILE_NAME}

    mv ~/.jenkins ~/.jenkins_bak
    rm -rf ~/.jenkins
    mv tmp/jenkins-master-backup ~/.jenkins
    
    # restart jenkins

}   

main(){
    restore_jenkins_from_s3
}

main