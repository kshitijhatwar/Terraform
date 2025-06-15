variable "region" {
  default = "ap-south-1"
}

variable "az1" {
  default = "ap-south-1a"
}

variable "az2" {
  default = "ap-south-1b"
}

variable "az3" {
  default = "ap-south-1c"
}

variable "ami_id" {
  default = "ami-0f918f7e67a3323f0"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "VPC_Name" {
  default = "ksh-vpc"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "VPC_PRVCIDRSUB1" {
  default = "10.0.1.0/24"
}

variable "VPC_PRVCIDRSUB2" {
  default = "10.0.2.0/24"
}

variable "VPC_PRVCIDRSUB3" {
  default = "10.0.3.0/24"
}

variable "VPC_PUBCIDRSUB1" {
  default = "10.0.101.0/24"
}

variable "VPC_PUBCIDRSUB2" {
  default = "10.0.102.0/24"
}

variable "VPC_PUBCIDRSUB3" {
  default = "10.0.103.0/24"
}

variable "dbname" {
  default = "accounts"
}

variable "dbuser" {
  default = "root"
}

variable "dbpass" {
  default = "admin123"
}

variable "rmquser" {
  default = "admin"
}

variable "rmqpass" {
  default = "admin123456789"
}


