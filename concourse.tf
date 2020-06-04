#     _____                                          
#    / ____|                                         
#   | |     ___  _ __   ___ ___  _   _ _ __ ___  ___ 
#   | |    / _ \| '_ \ / __/ _ \| | | | '__/ __|/ _ \
#   | |___| (_) | | | | (_| (_) | |_| | |  \__ \  __/
#    \_____\___/|_| |_|\___\___/ \__,_|_|  |___/\___|

# https://www.terraform.io/docs/providers/aws/r/ebs_volume.html
resource "aws_ebs_volume" "worker-ebs-0" {

  availability_zone = random_shuffle.availability-zones.result[0]
  size              = var.worker_storage_size

  tags = {
    Name = "worker-storage-ebs"
  }

}

resource "aws_ebs_volume" "worker-ebs-1" {

  availability_zone = random_shuffle.availability-zones.result[0]
  size              = var.worker_storage_size

  tags = {
    Name = "worker-storage-ebs"
  }

}

resource "local_file" "worker-persistent-volume-0-yaml" {

  content  = templatefile("${path.module}/k8s/worker-persistent-volume-0.tpl", { VOLUME_ID = aws_ebs_volume.worker-ebs-0.id })
  filename = "${path.module}/k8s/worker-persistent-volume-0.yaml"

}

resource "local_file" "worker-persistent-volume-1-yaml" {

  content  = templatefile("${path.module}/k8s/worker-persistent-volume-1.tpl", { VOLUME_ID = aws_ebs_volume.worker-ebs-1.id })
  filename = "${path.module}/k8s/worker-persistent-volume-1.yaml"

}

resource "aws_ebs_volume" "postgresql-ebs" {

  availability_zone = random_shuffle.availability-zones.result[0]
  size              = var.postgresql_storage_size

  tags = {
    Name = "postgresql-storage-ebs"
  }

}

resource "local_file" "postgresql-persistent-volume-0-yaml" {

  content  = templatefile("${path.module}/k8s/postgresql-persistent-volume-0.tpl", { VOLUME_ID = aws_ebs_volume.postgresql-ebs.id })
  filename = "${path.module}/k8s/postgresql-persistent-volume-0.yaml"

}

# https://www.terraform.io/docs/providers/random/r/password.html

resource "random_password" "admin-password" {

  length = 25

  lower = true
  min_lower = 5
  upper = true
  min_upper = 5
  number = true
  min_numeric = 5
  special = true
  min_special = 3

}

module "administrator-password-txt" {

  source = "./../terraform-aws-s3-object"
  # source = "jason-morsley/s3-object/aws"

  bucket_name = local.bucket_name

  key     = "/administrator-password.txt"
  content = random_password.admin-password.result

    mock_depends_on = [
      module.concourse-s3-bucket
    ]

}

resource "null_resource" "install-concourse" {

  depends_on = [
    aws_ebs_volume.worker-ebs-0,
    aws_ebs_volume.worker-ebs-1,
    aws_ebs_volume.postgresql-ebs,
    module.concourse-multiple-node-cluster
  ]
  
  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/install_concourse.sh"
    environment = {
      KUBERNETES_FOLDER = "${path.cwd}/k8s"
      KUBE_CONFIG       = "${path.cwd}/k8s/kube-config.yaml"
      CLUSTER_NAME      = var.cluster_name
      NAMESPACE         = var.namespace
    }
  }

}

# Is Concourse ready...?
resource "null_resource" "is-concourse-ready" {

  depends_on = [
    null_resource.install-concourse
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/${local.shared_scripts_folder}/kubernetes/are_deployments_ready.sh ${path.cwd}/k8s/kube-config.yaml ${var.namespace}"
  }

}

//resource "null_resource" "destroy-concourse" {
//
//  depends_on = [
//    aws_ebs_volume.worker-ebs,
//    aws_ebs_volume.postgresql-ebs,
//    local_file.kube-config-yaml
//  ]
//
////  connection {
////    type        = "ssh"
////    host        = data.aws_s3_bucket_object.node-public-dns.body
////    user        = "ubuntu"
////    private_key = data.aws_s3_bucket_object.node-private-key.body
////  }
//
//  # https://www.terraform.io/docs/provisioners/local-exec.html
//
//  provisioner "local-exec" {
//    when    = destroy
//    command = "chmod +x ${path.cwd}//destroy.sh && bash scripts/destroy.sh"
//  }
//
//}