module "vpc" {
  source = "./modules/vpc"

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  vpc_cidr_block  = var.vpc_cidr_block
  name_suffix     = local.name_suffix
  tags            = local.tags
}

module "apps" {
  source = "./modules/apps"

  container_image    = var.container_image
  name_suffix        = local.name_suffix
  tags               = local.tags
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  enable_https       = false #Staying http, cannot validate a domain for now.
  instance_type      = var.instance_type
  max_size           = var.max_size
  min_size           = var.min_size
  desired_capacity   = var.desired_capacity
}

