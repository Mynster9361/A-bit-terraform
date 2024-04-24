#===============================================================================
# vSphere Data
#===============================================================================

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  # Will be dynamic once pr is merged
  # https://github.com/hashicorp/terraform-provider-vsphere/issues/1893
  # https://github.com/hashicorp/terraform-provider-vsphere/pull/1896
  name          = var.vm_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "library" {
  name = "packer_templates"
}

data "vsphere_content_library_item" "item" {
  name       = "linux-rhel-9.2-develop"
  type       = "ovf"
  library_id = data.vsphere_content_library.library.id
}