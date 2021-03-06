current_environment               = "test"
region_name                       = "us-east-2"
ec2_ami_id                        = "ami-0368df804baf46241"
ec2_ami_key_pair                  = "vk-jenkins-ec2-slave-pair"
ec2_instance_type                 = "c5.large"
ec2_tag_name                      = "jenkins-slave-2"
ec2_subnet_id_value               = "subnet-09c5774cf2f5a145f"
vk_trfm_vpc_id_value              = "vpc-094a1bac729cc975d"
ec2_ssh_ingress_cidr_value        = "10.255.0.0/24"
ec2_ingress_appln_port_cidr_value = "10.255.0.0/24"
ec2_ingress_port_from             = "5000"
ec2_ingress_port_to               = "8000"
enable_public_ip_address          = true
user_data_script_file             = "jenkins-slave/init-scripts.sh"