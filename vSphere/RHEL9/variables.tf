#====================#
# vCenter connection #
#====================#

variable "vsphere_user" {
  description = "vSphere user name"
  type = string
}

variable "vsphere_password" {
  sensitive = true
  description = "vSphere password"
  type = string
}

variable "vsphere_vcenter" {
  description = "vCenter server FQDN or IP"
  type = string
}

variable "vsphere_unverified_ssl" {
  description = "Is the vCenter using a self signed certificate (true/false)"
  type = bool
  default = "true"
}

variable "vsphere_datacenter" {
  description = "vSphere datacenter"
  type = string
}

variable "vsphere_cluster" {
  description = "vSphere cluster"
  type = string
}


#=========================#
# vSphere virtual machine #
#=========================#
variable "vm_datastore" {
  # Will be dynamic once pr is merged
  # https://github.com/hashicorp/terraform-provider-vsphere/issues/1893
  # https://github.com/hashicorp/terraform-provider-vsphere/pull/1896
  description = "Datastore used for the vSphere virtual machines"
  type = string
}

variable "vm_network" {
  description = "Network used for the vSphere virtual machines"
  type = string
}

variable "vm_template" {
  description = "Template used to create the vSphere virtual machines"
  type = string
}

variable "vm_linked_clone" {
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  type = bool
  default = "false"
}

variable "vm_dns_suffix" {
  description = "Gateway for the vSphere virtual machine"
  type = list(string)
}

variable "vm_dns_servers" {
  description = "DNS for the vSphere virtual machine"
  type = list(string)
}

variable "vm_cpu" {
  description = "Number of vCPU for the vSphere virtual machines between 1 and 9"
  type = number
  validation {
    condition = var.vm_cpu >= 1 && var.vm_cpu <= 9
    error_message = "Invalid cpu value"
  }
}

variable "vm_ram" {
  description = "Amount of RAM for the vSphere virtual machines (example: 2048) between 1024 and 65536"
  type = number
  validation {
    condition     = contains([1024, 2048, 4096, 8192, 16384, 32768, 65536], var.vm_ram)
    error_message = "Invalid VM instance size provided"
  }
}

variable "vm_name" {
  description = "The name of the vSphere virtual machines and the hostname of the machine"
  type = string
  
}

variable "product_description" {
  description = "The description of the product that will be installed on the virtual machine"
  type = string
}


variable "guest_id" {
  description = "The guest ID of the virtual machine"
  type = string
  default = "rhel9_64Guest"
  validation {
    condition = contains(["rhel9_64Guest"], var.guest_id)
    error_message = "Invalid guest ID value"
  }
}

variable "vm_ip" {
  description = "The IP address of the virtual machine"
  type = string
  
}

variable "vm_subnet" {
  description = "The subnet of the virtual machine"
  type = string
}

variable "vm_gateway" {
  description = "The gateway of the virtual machine"
  type = string
  
}