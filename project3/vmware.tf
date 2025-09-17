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
  password             = "####"
  vsphere_server       = "333"
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = "YTTNM1PVTCLD"
}

data "vsphere_datastore" "datastore" {
  name          = "PrivateCloudStorage48"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "YTTNM1PVTCLDCLUSTER"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "Server-DMZ"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "Template-Ubuntu24"
  datacenter_id = data.vsphere_datacenter.dc.id
}



output "datacenter_id" {
  value = data.vsphere_datacenter.dc.id
}

output "datastore_id" {
  value = data.vsphere_datastore.datastore.id
}

output "cluster_id" {
  value = data.vsphere_compute_cluster.cluster.id
}

output "network_id" {
  value = data.vsphere_network.network.id
}

output "template_id" {
  value = data.vsphere_virtual_machine.template.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test-vm"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "terraform-test"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "10.0.3.167"
        ipv4_netmask = 23
      }

      ipv4_gateway = "10.0.2.1"
    }
  }
}
