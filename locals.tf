#      _                     _     
#     | |                   | |    
#     | |     ___   ___ __ _| |___ 
#     | |    / _ \ / __/ _` | / __|
#     | |___| (_) | (_| (_| | \__ \
#     |______\___/ \___\__,_|_|___/

locals {

  all_cidr_block = "0.0.0.0/0" # All possible IP address range
  
  bucket_name = "${var.cluster_name}-${random_pet.bucket-name.id}"
  
  cluster_id_tag = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned" 
  }
  
  node_1_name = "${var.ec2_name}-1"
  node_2_name = "${var.ec2_name}-2"
  node_3_name = "${var.ec2_name}-3"

  shared_scripts_folder = "shared-scripts-${random_pet.shared-folder.id}"
  
}