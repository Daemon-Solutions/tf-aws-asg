module "vpc" {
  source = "git@github.com:claranet/terraform-aws-vpc-modules.git?ref=v1.0.0"

  enable_dns_support   = true
  enable_dns_hostnames = true

  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  vpc_cidr_block = "10.0.0.0/16"

  public_cidr_block   = "10.0.1.0/17"
  public_subnet_count = 3

  private_cidr_block   = "10.0.128.0/17"
  private_subnet_count = 3
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_private_subnet_ids" {
  value = [module.vpc.private_subnet_ids]
}

output "vpc_public_subnet_ids" {
  value = [module.vpc.public_subnet_ids]
}
