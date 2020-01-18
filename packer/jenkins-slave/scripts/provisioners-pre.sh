#!/bin/bash

update_os() {
    sudo yum -y update
}

install_prerequisites() {
    sudo yum -y install wget zip unzip git
    REMOTE_FILES_FOLDER=/tmp/remotefiles
    sudo rm -rf ${REMOTE_FILES_FOLDER}
    sudo mkdir ${REMOTE_FILES_FOLDER}
    sudo chmod 0777 ${REMOTE_FILES_FOLDER}
    ls -ltr ${REMOTE_FILES_FOLDER}

}

install_iac_tools(){
    sudo wget https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip
    sudo unzip terraform_*_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    terraform --version
    sudo wget https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip
    sudo unzip packer_*_linux_amd64.zip
    sudo mv packer /usr/local/bin/
    rm -rf *.zip
}

main(){
    update_os

    install_prerequisites

    install_iac_tools
}

main