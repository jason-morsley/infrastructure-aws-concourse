#       _____                                          
#      / ____|                                         
#     | |     ___  _ __   ___ ___  _   _ _ __ ___  ___ 
#     | |    / _ \| '_ \ / __/ _ \| | | | '__/ __|/ _ \
#     | |___| (_) | | | | (_| (_) | |_| | |  \__ \  __/
#      \_____\___/|_| |_|\___\___/ \__,_|_|  |___/\___|
#            _____ _           _            
#           / ____| |         | |           
#          | |    | |_   _ ___| |_ ___ _ __ 
#          | |    | | | | / __| __/ _ \ '__|
#          | |____| | |_| \__ \ ||  __/ |   
#           \_____|_|\__,_|___/\__\___|_|   

module "concourse-multiple-node-cluster" {

  #source = "./../terraform-aws-kubernetes-cluster"
  source = "jason-morsley/kubernetes-cluster/aws"

  cluster_name = var.cluster_name 
  
  bucket_name = local.bucket_name
  
  ec2_data = [
    {
      user = "ubuntu"
      role = ["controlplane", "etcd", "worker"]
      public_ip = module.concourse-node-1-ec2.public_ip
      private_ip = module.concourse-node-1-ec2.private_ip
      encoded_private_key = module.concourse-node-1-ec2.encoded_private_key
    }//,
//    {
//      user = "ubuntu"
//      role = ["controlplane", "etcd", "worker"]
//      public_ip = module.concourse-node-2-ec2.public_ip
//      private_ip = module.concourse-node-2-ec2.private_ip
//      encoded_private_key = module.concourse-node-2-ec2.encoded_private_key
//    },
//    {
//      user = "ubuntu"
//      role = ["controlplane", "etcd", "worker"]
//      public_ip = module.concourse-node-3-ec2.public_ip
//      private_ip = module.concourse-node-3-ec2.private_ip
//      encoded_private_key = module.concourse-node-3-ec2.encoded_private_key
//    }
  ]

  mock_depends_on = [
    module.concourse-vpc,
    module.concourse-allow-all-sg,
    module.concourse-node-1-ec2//,
//    module.concourse-node-2-ec2,
//    module.concourse-node-3-ec2
  ]
  
}