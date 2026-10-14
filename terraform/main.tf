module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source              = "./modules/ec2"
  sub_pub_id          = module.vpc.sub_pub_id
  public_key_valkyrie = module.keys.public_key_valkyrie
  sgp_pub_id          = module.security_group.sgp_pub_id
}

module "router_table" {
  source     = "./modules/router_table"
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.vpc.igw_id
  sub_pub_id = module.vpc.sub_pub_id
}

module "keys" {
  source = "./modules/keys"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  ec2_ip = module.ec2.ec2_ip
}


module "s3" {
  source = "./modules/s3"
}
