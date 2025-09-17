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
