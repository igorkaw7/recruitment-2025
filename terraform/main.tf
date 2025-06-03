provider "aws" {
  region = var.aws_region
}

module "nsg" {
  source  = "./modules/nsg"
  sg_name = "weatherapp-sg"
}

module "compute" {
  source              = "./modules/compute"
  admin1_ssh_key_name = "weatherapp-admin1-key"
  admin1_ssh_key_path = var.admin1_ssh_key_path
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  security_group_id   = module.nsg.security_group_id
  volume_size         = 10
  volume_type         = "gp3"
  instance_name       = "weatherapp"
}
