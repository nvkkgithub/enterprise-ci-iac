resource "aws_instance" "ek_launch_ec2_instance" {
  ami           = "${var.ec2_ami_id}"
  instance_type = "${var.ec2_instance_type}"
  key_name      = "${var.ec2_ami_key_pair}"

  associate_public_ip_address = var.enable_public_ip_address

  security_groups = ["${aws_security_group.vk_ec2_sg.id}"]
  tags = {
    Environment = "${var.current_environment}"
    Name        = "${var.ec2_tag_name}"
  }

  user_data = "${base64encode(file("${var.user_data_script_file}"))}"

  private_ip = "${var.ec2_private_ip_address}"

  subnet_id = "${var.ec2_subnet_id_value}"

}

resource "aws_security_group" "vk_ec2_sg" {
  vpc_id = "${var.vk_trfm_vpc_id_value}"

  ingress {
    cidr_blocks = ["${var.ec2_ssh_ingress_cidr_value}"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["${var.ec2_ingress_appln_port_cidr_value}"]
    from_port   = var.ec2_ingress_port_from
    to_port     = var.ec2_ingress_port_to
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
    Name        = "${var.ec2_tag_name}_ec2_sg"
  }
}
output "Instance_Public_DNS" {
  value = aws_instance.ek_launch_ec2_instance.public_dns
}
output "Instance_Public_IPAddress" {
  value = aws_instance.ek_launch_ec2_instance.public_ip
}