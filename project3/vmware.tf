terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.0"
    }
  }
}

provider "vsphere" {
  user                 = "khatwar@yotta.com"
  password             = "Sushilamummy2@"
  vsphere_server       = "10.0.24.20"
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = "YTTNM1PVTCLD"
}

output "datacenter_id" {
  value = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "/"
  datacenter_id = data.vsphere_datacenter.dc.id
}

output "cluster_id" {
  value = data.vsphere_compute_cluster.cluster.id
}
output "cluster_name" {
  value = data.vsphere_compute_cluster.cluster.name
}
