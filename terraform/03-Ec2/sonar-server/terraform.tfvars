current_environment               = "test"
region_name                       = "us-east-2"
ec2_ami_id                        = "ami-00de06081dba6534f"
ec2_ami_key_pair                  = "vk-ubuntu-sonar-servers-pair"
ec2_instance_type                 = "t3.medium"
ec2_tag_name                      = "sonar-n-others-server"
ec2_subnet_id_value               = "subnet-0bac9e7ee474304fb"
vk_trfm_vpc_id_value              = "vpc-094a1bac729cc975d"
ec2_ssh_ingress_cidr_value        = "0.0.0.0/0"
ec2_ingress_appln_port_cidr_value = "0.0.0.0/0"
ec2_ingress_port_from             = "5500"
ec2_ingress_port_to               = "9900"
enable_public_ip_address          = true
user_data_script_file             = "init-scripts.sh"
ec2_private_ip_address            = "10.255.0.46"