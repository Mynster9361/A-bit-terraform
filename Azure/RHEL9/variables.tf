# location for the VM in Azure
variable "location" {
  type        = string
  description = "The Azure Region in which the resources in this example should exist"
  default     = "westeurope"

  validation {
    condition     = contains(["westeurope", "northeurope", "eastus", "westus", "canadacentral", "canadaeast"], var.location)
    error_message = "Invalid location. The location must be one of: westeurope, northeurope, eastus, westus, canadacentral, canadaeast."
  }
}

# username for the VM
variable "username" {
  default = "svcansibleman"
  validation {
    condition     = var.username == "svcansibleman"
    error_message = "Invalid username. This can not be changed it is used for ansible management by Team Reliability."
  }
}

# ssh_publickey for the VM
variable "ssh_publickey" {
  type       = string
  sensitive  = true
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID to use for the Azure resources"
  default     = ""
  validation {
    condition     = can(regex("^[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}$", var.subscription_id))
    error_message = "Invalid subscription ID. The subscription ID must be a valid GUID."
  }
}

# determine where it should be located
variable "vm_location" {
  type        = string
  description = "The location of the VM"
  default     = "AZU"
  validation {
    condition     = var.vm_location == "AZU"
    error_message = "Invalid environment. The environment must be: AZU"
  }
}

variable "vm_instance" {
  type        = string
  description = "The instance of VM f.eks. AZUZABPRO01, AZUZABPRO02, etc."
  default     = "01"

  validation {
    condition     = can(regex("^\\d{2}$", var.vm_instance)) && (tonumber(var.vm_instance) <= 99)
    error_message = "Invalid VM instance. The VM instance must be a two-digit number between 01 and 99."
  }
}

variable "vm_size" {
  type        = string
  description = "The size of the VM. See https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general for more information."
  default     = "Standard_DS1_v2"
}

variable "environment" {
  type        = string
  description = "The environment to be installed on the VM - f.eks. DEV, TEST, PROD, etc."
  validation {
    condition     = upper(var.environment) == "DEV" || upper(var.environment) == "TEST" || upper(var.environment) == "PROD"
    error_message = "Invalid environment. The environment must be one of: DEV, TEST, PRO."
  }
}

# product shortname
variable "product_shortname" {
  type        = string
  description = "The shortname for the product to be installed on the VM - f.eks. ZAB, ZAS, DC, etc."
  validation {
    condition     = length(var.product_shortname) <= 6
    error_message = "Invalid product name. The product name must be 6 characters or less."
  }
}
