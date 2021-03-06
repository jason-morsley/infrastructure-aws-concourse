#       _____                      _ _         
#      / ____|                    (_) |        
#     | (___   ___  ___ _   _ _ __ _| |_ _   _ 
#      \___ \ / _ \/ __| | | | '__| | __| | | |
#      ____) |  __/ (__| |_| | |  | | |_| |_| |
#     |_____/ \___|\___|\__,_|_|  |_|\__|\__, |
#            _____                        __/ |
#           / ____|                      |___/ 
#          | |  __ _ __ ___  _   _ _ __  
#          | | |_ | '__/ _ \| | | | '_ \ 
#          | |__| | | | (_) | |_| | |_) |
#           \_____|_|  \___/ \__,_| .__/ 
#                                 | |    
#                                 |_|     

module "concourse-allow-all-sg" {

  #source = "./../terraform-aws-security-group"
  source = "jason-morsley/security-group/aws"

  name = "allow-all"
  description = "Allow All!" # ToDo --> This needs tightening!

  vpc_id = module.concourse-vpc.id

  ingress = [
    {
      description = "Allow All"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
      local.all_cidr_block]
    }
//    {
//    description = "Allow SSH"
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = [ local.all_cidr_block ]
//    },
//    {
//      description = "Allow KupeAPI (RKE)"
//      from_port   = 6443
//      to_port     = 6443
//      protocol    = "tcp"
//      cidr_blocks = [ local.all_cidr_block ]
//    },
//    {
//      description = "Allow etcd"
//      from_port   = 2379
//      to_port     = 2380
//      protocol    = "tcp"
//      cidr_blocks = [ local.all_cidr_block ]
//    }
  ]
  
  egress = [{
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ local.all_cidr_block ]
  }]

  tags = local.cluster_id_tag
  
}