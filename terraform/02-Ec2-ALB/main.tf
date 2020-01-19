terraform {
  backend "s3" {
  }
}
resource "aws_launch_template" "vk_aws_asg_launch_template" {
  name_prefix   = "${var.vk_aws_ec2_alb_tag}_lnch_tmpl"
  image_id      = "${var.ec2_ami_id}"
  instance_type = "${var.ec2_instance_type}"
  key_name      = "${var.ami_key_pair_name}"

  network_interfaces {
    associate_public_ip_address = var.ec2_associate_public_ip
    security_groups             = ["${aws_security_group.vk_ec2_sg.id}"]
    subnet_id                   = "${var.vk_subnet_b1_value}"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Environment = "${var.current_environment}"
      Name        = "${var.vk_aws_ec2_alb_tag}_lnch_tmpl"
    }
  }

  user_data = "${base64encode(file("${var.user_data_script_file}"))}"
}
resource "aws_autoscaling_group" "vk_aws_launch_grp" {
  availability_zones = ["${var.vk_subnet_b1_az_value}"]

  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  launch_template {
    id      = "${aws_launch_template.vk_aws_asg_launch_template.id}"
    version = "$Latest"
  }

  tags = [
    {
      key                 = "Environment"
      value               = "${var.current_environment}"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "${var.vk_aws_ec2_alb_tag}_ec2_asg"
      propagate_at_launch = true
    }
  ]
}
resource "aws_security_group" "vk_ec2_sg" {
  name = "${var.vk_aws_ec2_alb_tag}_ec2_sg"

  vpc_id = "${var.vk_trfm_vpc_id_value}"

  ingress {
    cidr_blocks = ["${var.ec2_ssh_ingress_cidr_value}"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["${var.ec2_ingress_appln_port_cidr_value}"]
    from_port   = var.ec2_ingress_port1
    to_port     = var.ec2_ingress_port1
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["${var.ec2_ingress_appln_port_cidr_value}"]
    from_port   = var.ec2_ingress_port2
    to_port     = var.ec2_ingress_port2
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_ec2_alb_tag}_ec2_sg"
  }
}

resource "aws_autoscaling_attachment" "vk_asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.vk_aws_launch_grp.id}"
  alb_target_group_arn   = "${var.load_balancer_target_grp_arn_value}"
}
