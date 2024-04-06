module "my_network" {
  source              = "./modules/my_network"
  network_config_path = "./config/my_network.yaml"
}

module "my_dmz_sg" {
  source           = "./modules/my_network_security"
  vpc_id           = module.my_network.out_vpc_id
  sg_ingress_rules = local.dmz_sg_ingress_rules

  sg_usage = "dmz_sg"
}

module "my_private_sg" {
  source           = "./modules/my_network_security"
  vpc_id           = module.my_network.out_vpc_id
  sg_ingress_rules = local.private_sg_ingress_rules
  depends_on       = [module.my_dmz_sg]

  sg_usage = "private_sg"
}
