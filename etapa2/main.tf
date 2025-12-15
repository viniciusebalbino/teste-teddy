module "networking" {
  source = "./_modules/networking"
  
  cidr_block  = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  az          = "us-east-1a"
}

module "security" {
  source = "./_modules/security"

  vpc_id          = module.networking.vpc_id
  public_key_path = "~/.ssh/id_rsa.pub"
}

module "compute" {
  source = "./_modules/ec2_docker"

  ec2_name          = "ec2Docker-teddy"
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.security.web_sg_id
  key_name          = module.security.key_name
  instance_type     = "t2.micro"
}

output "ip_acesso" {
  value = module.compute.server_ip
}
