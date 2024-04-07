module "my_network" {
  source              = "./modules/my_network"
  network_config_path = "./config/my_network.yaml"
}

module "my_dmz_sg" {
  source           = "./modules/my_network_security"
  vpc_id           = module.my_network.out_vpc_id
  sg_ingress_rules = local.dmz_sg_ingress_rules

  sg_usage = "dmz_sg" # my_private_sg will use this 'tag key' to identify
}

module "my_private_sg" {
  source           = "./modules/my_network_security"
  vpc_id           = module.my_network.out_vpc_id
  sg_ingress_rules = local.private_sg_ingress_rules
  depends_on       = [module.my_dmz_sg]

  sg_usage = "private_sg"
}

resource "aws_key_pair" "my_public_key" {
  key_name   = "${var.tag_name_prefix}-key"
  public_key = var.public_key

  tags = {
    Name = "${var.tag_name_prefix}-pubkey"
  }
}

## EC2 instance 01 - public subnet
resource "aws_instance" "my_dmz_ec2_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.my_public_key.key_name

  subnet_id              = module.my_network.out_public_subnets_ids[0]
  vpc_security_group_ids = [module.my_dmz_sg.out_security_group.id]

  tags = {
    Name = "${var.tag_name_prefix}-dmz01"
  }
}

## EC2 instance 02 - private subnet
resource "aws_instance" "my_private_ec2_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.my_public_key.key_name

  subnet_id              = module.my_network.out_private_subnets_ids[0]
  vpc_security_group_ids = [module.my_private_sg.out_security_group.id]

  tags = {
    Name = "${var.tag_name_prefix}-private01"
  }
}
