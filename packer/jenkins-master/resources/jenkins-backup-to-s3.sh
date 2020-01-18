#!/bin/bash

export MASTER_BACK_UP_FOLDER=/tmp/jenkins-master-backup
export BACKUP_FILE_NAME=jenkins-master-backup.zip

backup_jenkins_master_to_s3(){
    # https://aws.amazon.com/getting-started/tutorials/backup-to-s3-cli/
    # aws configure
    # cross-check, aws_access_key_id & aws_secret_access_key updated in ~/.aws/credentials
    # cross-check, profile is updated in updated in ~/.aws/config

    rm -rf ${MASTER_BACK_UP_FOLDER}
    mkdir -p ${MASTER_BACK_UP_FOLDER}

    # move to temp backup
    mkdir -p /var/jenkins_backup_process
    cd /var/jenkins_backup_process
    rsync -ar ~/.jenkins/* ${MASTER_BACK_UP_FOLDER}/
    zip -r ${BACKUP_FILE_NAME} ${MASTER_BACK_UP_FOLDER}/

    # aws s3 cp "${MASTER_BACK_UP_FOLDER}" s3://vk-test-jenkins-backup/jenkins-master-backup --recursive
    aws s3 cp "${BACKUP_FILE_NAME}" s3://vk-test-jenkins-backup/jenkins-master-backup/

    rm -rf ${MASTER_BACK_UP_FOLDER}
    rm -rf ${BACKUP_FILE_NAME}

}

main() {
    backup_jenkins_master_to_s3
}

main