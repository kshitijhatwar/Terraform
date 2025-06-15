module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_Name
  cidr = var.VPC_CIDR

  azs             = [var.az1, var.az2, var.az3]
  private_subnets = [var.VPC_PRVCIDRSUB1, var.VPC_PRVCIDRSUB2, var.VPC_PRVCIDRSUB3]
  public_subnets  = [var.VPC_PUBCIDRSUB1, var.VPC_PUBCIDRSUB2, var.VPC_PUBCIDRSUB3]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  map_public_ip_on_launch = true


}