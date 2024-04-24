output "vm_name" {
  value = vsphere_virtual_machine.vm.name
}

output "vm_description" {
  value = vsphere_virtual_machine.vm.annotation
}

output "vm_ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "vm_cpu" {
  value = vsphere_virtual_machine.vm.num_cpus
}

output "vm_ram" {
  value = vsphere_virtual_machine.vm.memory
}

output "vm_disk_size" {
  value = "${vsphere_virtual_machine.vm.disk[0].size} GB"
}

output "vm_gateway" {
  value = var.vm_gateway
}

output "vm_dns_servers" {
  value = var.vm_dns_servers
}

output "template_data" {
  value = data.vsphere_content_library_item.item
}
output "size" {
  value = data.vsphere_virtual_machine.template.disks.0.size
}