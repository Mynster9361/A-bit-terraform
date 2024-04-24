#===============================================================================
# vSphere Resources
#===============================================================================

resource "vsphere_virtual_machine" "vm" {
  name                    = upper(var.vm_name)
  resource_pool_id        = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id            = data.vsphere_datastore.datastore.id
  firmware                = "efi"
  memory_hot_add_enabled  = true
  efi_secure_boot_enabled = true
  tools_upgrade_policy    = "upgradeAtPowerCycle"

  num_cpus = var.vm_cpu
  memory   = var.vm_ram
  guest_id = var.guest_id
  annotation = "Description: ${var.product_description}"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "${upper(var.vm_name)}.vmdk"
    size             = 40 #data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = true
    thin_provisioned = false
  }
  cdrom {
    client_device = true
  }


  clone {
    template_uuid = data.vsphere_content_library_item.item.id #data.vsphere_virtual_machine.template.id #data.vsphere_content_library_item.template.id #data.vsphere_virtual_machine.template.id
    #linked_clone  = var.vm_linked_clone

    customize {
      timeout = "20"

      linux_options {
        host_name = upper(var.vm_name)
        domain    = upper(var.vm_name)
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_subnet
      }

      ipv4_gateway    = var.vm_gateway
      dns_server_list = var.vm_dns_servers
      dns_suffix_list = var.vm_dns_suffix
      
    }
  }
}
