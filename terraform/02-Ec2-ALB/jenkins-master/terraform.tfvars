current_environment                = "test"
region_name                        = "us-east-2"
vk_aws_ec2_alb_tag                 = "jenkins-master"
ec2_ami_id                         = "ami-0fe1466fffbe2f7ec"
ec2_instance_type                  = "c5.large"
ami_key_pair_name                  = "vk-jenkins-master-pair"
ec2_associate_public_ip            = "true"
vk_subnet_b1_value                 = "subnet-0811fea42c4eefc6a"
user_data_script_file              = "jenkins-master/master-scripts.sh"
vk_subnet_b1_az_value              = "us-east-2a"
asg_desired_capacity               = 1
asg_max_size                       = 1
asg_min_size                       = 1
vk_trfm_vpc_id_value               = "vpc-094a1bac729cc975d"
ec2_ssh_ingress_cidr_value         = "10.255.0.0/24"
ec2_ingress_appln_port_cidr_value  = "10.255.0.0/24"
ec2_ingress_port1                  = "8080"
ec2_ingress_port2                  = "5000"
load_balancer_target_grp_arn_value = "arn:aws:elasticloadbalancing:us-east-2:710974406600:targetgroup/vkenterprise-ci-alb-tg/f76ebfdb4cc3814a"
