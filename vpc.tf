#     __      __  _____     _____ 
#     \ \    / / |  __ \   / ____|
#      \ \  / /  | |__) | | |     
#       \ \/ /   |  ___/  | |     
#        \  /    | |      | |____ 
#         \/     |_|       \_____|

module "concourse-vpc" {

  #source = "./../terraform-aws-vpc"
  source = "jason-morsley/vpc/aws"
  
  name = var.vpc_name
  
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  //private_subnet_cidrs = var.private_subnet_cidrs

  public_subnet_tags = local.cluster_id_tag

  availability_zones = [ random_shuffle.availability-zones.result[0] ]
  
}