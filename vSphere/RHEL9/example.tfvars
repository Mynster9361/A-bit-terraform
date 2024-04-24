#===============================================================================
# Minimum variables needed for a Virtual machine deployment for RHEL 9.2 on vSphere 
# If you need more information on the variables please have a look in the variables.tf file
#===============================================================================

#===============================================================================
#   Vcenter configuration
#===============================================================================

# The vCenter server IP or hostname #
vsphere_vcenter = "vcenter.contoso.local"
# The vCenter server username & password #
vsphere_user = "username"
vsphere_password = "password"
# Using ssl or not #
vsphere_unverified_ssl = true

# The datacenter to use to deploy the virtual machine #
vsphere_datacenter = "datacenter1"
# The cluster to use to deploy the virtual machine #
vsphere_cluster = "cluster1"
# The datastore to use to deploy the virtual machine #
vm_datastore = "datastore1"


#===============================================================================
#   Virtual machine configuration
#===============================================================================

# The template path to use to deploy the virtual machine #
vm_template = "folder/VMware/Template/RHEL9.2"

# The name of the virtual machine #
vm_name = "RHELTEST01"

# The number of vCPU allocated to the virtual machine 1-9 #
vm_cpu = 1

# The amount of RAM allocated to the virtual machine #
vm_ram = 4096

# The vSphere network name used by the virtual machine #
vm_network = ""

# The IP address of the virtual machine #
vm_ip = "10.0.0.3"

# The subnet mask of the virtual machine #
vm_subnet = "24"

# The gateway of the virtual machine #
vm_gateway = "10.0.0.1"

# The dns servers used by the virtual machine #
vm_dns_servers = ["10.0.0.1", "10.0.0.2"]

# The dns suffix used by the virtual machine #
vm_dns_suffix = ["Contoso.local"]

# Description of the virtual machine #
product_description = "this is a test deployment while interacting with terraform to vsphere RHEL 9.2"
