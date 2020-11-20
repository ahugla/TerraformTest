#   ["un","deux"]
#
#


variable "vCenterPassword" {
  default = "VMware1!"
  description = "Password du compte 'admin' de vCenter"
}


variable "FolderList" {
  type = set(string)
  description = "Nom des Folders"
}


provider "vsphere" {
  user           = "admin@cpod-vrealize.az-fkd.cloud-garage.net"
  password       = var.vCenterPassword
  vsphere_server = "vcsa.cpod-vrealize.az-fkd.cloud-garage.net"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}



data "vsphere_datacenter" "my_dc" {
  name = "cPod-VREALIZE"
}


resource "vsphere_folder" "folder" {
  for_each =  var.FolderList
  path          = "TFdemo/${each.value}"
  #for_each =  toset(var.FolderList)
  #path          = "TFdemo/${each.value}"
  #count         = length(var.FolderList)
  #path          = "TFdemo/${var.FolderList[count.index]}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.my_dc.id
}

