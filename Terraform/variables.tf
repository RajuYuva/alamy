variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ami" {

  default = "ami-080e1f13689e07408"
    
}

variable "vpc_id" {
  default = "module.vpc.vpc_id"
}
variable "vpcCIDR" {
  default = "172.21.0.0/16"
}
variable "VPC_Name" {
  default = "alamy-vpc"
}
variable "zone1" {
  default = "us-east-1a"
}
variable "zone2" {
  default = "us-east-1b"
}
variable "zone3" {
  default = "us-east-2a"
}
variable "zone4" {
  default = "us-east-2b"
}
variable "PubSubCIDR" {
  default = "172.21.1.0/24"
}
variable "PrivSubCIDR" {
  default = "172.21.2.0/24"
}
variable "Priv_Key_Path" {
  default = "alamykey"
}
variable "Pub_Key_Path" {
  default = "alamykey.pub"
}

