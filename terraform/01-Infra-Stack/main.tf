terraform {
  backend "s3" {
  }
}
resource "aws_vpc" "vk_trfm_new_vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_vpc"
  }
}
resource "aws_subnet" "vk_subnet_a" {
  cidr_block        = "${var.subnet_a_cidr}"
  vpc_id            = "${aws_vpc.vk_trfm_new_vpc.id}"
  availability_zone = "${var.subnet_a_az}"

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_jumpbox"
  }
}
resource "aws_subnet" "vk_subnet_b1" {
  cidr_block        = "${var.subnet_b1_cidr}"
  vpc_id            = "${aws_vpc.vk_trfm_new_vpc.id}"
  availability_zone = "${var.subnet_b1_az}"

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_master_az1"
  }
}
resource "aws_subnet" "vk_subnet_b2" {
  cidr_block        = "${var.subnet_b2_cidr}"
  vpc_id            = "${aws_vpc.vk_trfm_new_vpc.id}"
  availability_zone = "${var.subnet_b2_az}"

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_master_az2"
  }
}
resource "aws_subnet" "vk_subnet_c" {
  cidr_block        = "${var.subnet_c_cidr}"
  vpc_id            = "${aws_vpc.vk_trfm_new_vpc.id}"
  availability_zone = "${var.subnet_c_az}"

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_slave"
  }
}
resource "aws_internet_gateway" "vk_trfm_new_gw" {
  vpc_id = "${aws_vpc.vk_trfm_new_vpc.id}"

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_igw"
  }
}
resource "aws_route_table" "vk_trfm_route_table_env" {
  vpc_id = "${aws_vpc.vk_trfm_new_vpc.id}"
  route {
    cidr_block = "${var.cidr_routing_table}"
    gateway_id = "${aws_internet_gateway.vk_trfm_new_gw.id}"
  }

  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}_rt_tbl"
  }
}
resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = "${aws_subnet.vk_subnet_a.id}"
  route_table_id = "${aws_route_table.vk_trfm_route_table_env.id}"
}
resource "aws_route_table_association" "subnet_b1_association" {
  subnet_id      = "${aws_subnet.vk_subnet_b1.id}"
  route_table_id = "${aws_route_table.vk_trfm_route_table_env.id}"
}
resource "aws_route_table_association" "subnet_b2_association" {
  subnet_id      = "${aws_subnet.vk_subnet_b2.id}"
  route_table_id = "${aws_route_table.vk_trfm_route_table_env.id}"
}
resource "aws_route_table_association" "subnet_c_association" {
  subnet_id      = "${aws_subnet.vk_subnet_c.id}"
  route_table_id = "${aws_route_table.vk_trfm_route_table_env.id}"
}
resource "aws_lb" "vk_trfm_new_lb" {
  name                       = "${var.vk_trfm_alb_name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.vk_aws_alb_sg.id}"]
  subnets                    = ["${aws_subnet.vk_subnet_b1.id}", "${aws_subnet.vk_subnet_b2.id}"]
  enable_deletion_protection = false

  tags = {
    Environment = "${var.current_environment}"
  }
}
resource "aws_lb_listener" "vk_trfm_lb_listener" {
  load_balancer_arn = "${aws_lb.vk_trfm_new_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  //port              = "443"
  //protocol          = "HTTPS"
  //ssl_policy        = "ELBSecurityPolicy-2016-08"
  //certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.vk_trfm_lb_new_tg.arn}"
  }
}
resource "aws_lb_target_group" "vk_trfm_lb_new_tg" {
  name     = "${var.vk_trfm_alb_name}-alb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vk_trfm_new_vpc.id}"
}
resource "aws_security_group" "vk_aws_alb_sg" {
  name   = "${var.vk_trfm_alb_name}-alb-sg"
  vpc_id = "${aws_vpc.vk_trfm_new_vpc.id}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
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
    Name        = "${var.vk_aws_env_vpc_n_subnet_tag}-alb-sg"
  }
}
output "load_balancer_target_grp_arn" {
  value = aws_lb_target_group.vk_trfm_lb_new_tg.arn
}
output "load_balancer_name_host" {
  value = aws_lb.vk_trfm_new_lb.dns_name
}
output "load_balancer_id" {
  value = aws_lb.vk_trfm_new_lb.id
}