current_environment         = "test"
region_name                 = "us-east-2"
vk_aws_env_vpc_n_subnet_tag = "vk-entrp-jenkins"
vpc_cidr_block              = "10.255.0.0/24"
subnet_a_cidr               = "10.255.0.32/27"
subnet_b1_cidr              = "10.255.0.64/27"
subnet_b2_cidr              = "10.255.0.96/27"
subnet_c_cidr               = "10.255.0.128/25"
subnet_a_az                 = "us-east-2a"
subnet_b1_az                = "us-east-2a"
subnet_b2_az                = "us-east-2b"
subnet_c_az                 = "us-east-2c"
vk_trfm_alb_name            = "vkenterprise-ci"
s3_bucket_name              = "vk-enterprise-jenkins-infra-bckt"
s3_bucket_key               = "jenkins-master/test/infra/terraform.tfstate"
cidr_routing_table          = "0.0.0.0/0"