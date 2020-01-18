provider "aws" {
  region  = "${var.region_name}"
  version = "~> 2.44"
  profile = "vk_env_admin_user"
}
