#     __      __        _       _     _           
#     \ \    / /       (_)     | |   | |          
#      \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___ 
#       \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#        \  / (_| | |  | | (_| | |_) | |  __/\__ \
#         \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

# AWS

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "region" {
  type = string
  default = "eu-west-2" # London
}

# VPC

variable "vpc_name" {
  type = string
  default = "concourse"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

//variable "private_subnet_cidrs" {
//  type = list(string)
//  default = ["10.0.2.0/24","10.0.4.0/24","10.0.6.0/24"]
//}

# IAM Role

variable "iam_role_name" {
  type = string
  default = "concourse"
}

# EC2 (Node)

variable "ec2_name" {
  type = string
  default = "node"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.xlarge"
}

# Cluster

variable "cluster_name" {
  type = string
  default = "concourse"
}

# Concourse

variable "namespace" {
  default = "concourse"
}

variable "worker_storage_size" {
  type = number
  default = 20 # In GiBs
}

variable "postgresql_storage_size" {
  type = number
  default = 10 # In GiBs
}

# Domain

variable "domain" {
  default = "jasonmorsley.io"
}

variable "sub_domain" {
  default = "concourse"
}

# Cert-Manager

variable "cert_manager_namespace" {
  default = "cert-manager"
}