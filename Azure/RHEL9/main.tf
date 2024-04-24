locals {
  vmname = "${upper(var.vm_location)}${upper(var.product_shortname)}${upper(var.environment)}${var.vm_instance}"
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = local.vmname
  location = var.location
}

# Create network interface
resource "azurerm_network_interface" "main" {
  name                = local.vmname
  location            = var.location
  resource_group_name = "Core_Services"

  ip_configuration {
    name                          = local.vmname
    subnet_id                     = data.azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Create virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  name                            = local.vmname
  computer_name                   = local.vmname
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = var.vm_size
  admin_username                  = var.username
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]
  admin_ssh_key {
    username   = var.username
    public_key = var.ssh_publickey
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "${local.vmname}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  tags = {
    Owner      = data.azurerm_subscription.current.tags.Owner
    Product     = var.product_shortname
    Department = title(data.azurerm_subscription.current.tags.department)
    Env = upper(var.environment)
    CreatedBy = "Terraform"
  }
}
/*
# This is just an example of how we could run ssh commands to the newly created VM
resource "null_resource" "configure_unattended_upgrades" {
  count = 3

  connection {
    type        = "ssh"
    host = azurerm_linux_virtual_machine.main.private_ip_address
    user = "azureuser"
    private_key= tls_private_key.main.private_key_pem
    agent = false
    timeout = "3m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install unattended-upgrades"
    ]
  }
}
*/