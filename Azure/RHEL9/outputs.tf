output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "subnet_id" {
  value = data.azurerm_subnet.main.id
}

output "network_interface_id" {
  value = azurerm_network_interface.main.id
}

output "vm_ip_address" {
  value = azurerm_linux_virtual_machine.main.private_ip_address
}

output "tags" {
  value = azurerm_linux_virtual_machine.main.tags
}