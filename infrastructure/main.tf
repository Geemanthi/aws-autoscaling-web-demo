module "vpc" {
	source = "./modules/vpc"

	private_subnets = var.private_subnets
	public_subnets  = var.public_subnets
	vpc_cidr_block  = var.vpc_cidr_block
	name_suffix     = local.name_suffix
	tags            = local.tags
}