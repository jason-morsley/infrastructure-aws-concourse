#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|

output "private_ip_node_1" {
  value = module.concourse-node-1-ec2.private_ip
}

//output "private_ip_node-2" {
//  value = module.concourse-node-2-ec2.private_ip
//}
//
//output "private_ip_node-3" {
//  value = module.concourse-node-3-ec2.private_ip
//}

output "public_ip_node_1" {
  value = module.concourse-node-1-ec2.public_ip
}

//output "public_ip_node_2" {
//  value = module.concourse-node-2-ec2.public_ip
//}
//
//output "public_ip_node_3" {
//  value = module.concourse-node-3-ec2.public_ip
//}

output "public_dns_node_1" {
  value = module.concourse-node-1-ec2.public_dns
}

//output "public_dns_node_2" {
//  value = module.concourse-node-2-ec2.public_dns
//}
//
//output "public_dns_node_3" {
//  value = module.concourse-node-3-ec2.public_dns
//}

output "ssh_command_node_1" {
  value = module.concourse-node-1-ec2.ssh_command
}

//output "ssh_command_node_2" {
//  value = module.concourse-node-2-ec2.ssh_command
//}
//
//output "ssh_command_node_3" {
//  value = module.concourse-node-3-ec2.ssh_command
//}

output "export_kubeconfig_command" {
  value = module.concourse-multiple-node-cluster.export_kubeconfig_command
}

output "kubectl_kubeconfig_command" {
  value = module.concourse-multiple-node-cluster.kubectl_kubeconfig_command
}

output "bucket_name" {
  value = local.bucket_name
}