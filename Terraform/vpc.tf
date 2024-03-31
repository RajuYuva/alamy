#creating VPC using terraform registry modules, it will also creates one public and private subnet along with NAT gateway

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.7.0"
  name            = var.VPC_Name
  cidr            = var.vpcCIDR
  azs             = [var.zone1, var.zone2]
  private_subnets = [var.PrivSubCIDR]
  public_subnets  = [var.PubSubCIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    terraform = "true"
    Env       = "alamy"
  }
}
