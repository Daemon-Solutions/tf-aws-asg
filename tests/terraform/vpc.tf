module "vpc" {
  source               = "git::ssh://git@gogs.bashton.net/Bashton-Terraform-Modules/tf-aws-vpc-natgw.git?ref=v1.0.0"
  name                 = "awspec-testing"
  ipv4_cidr            = "10.0.0.0/16"
  public_ipv4_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_ipv4_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  azs                  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "eips" {
  value = ["${module.vpc.nat_eips}"]
}
