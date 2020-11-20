
#
#  {"name":"un","name":"deux"}     =>   meme key  =>   rajoute qu'un folder (le dernier)
#  {"name1":"un","name2":"deux"}   =>   key diffente  =>   rajoute les deux folders
#


variable "vCenterPassword" {
  default = "VMware1!"
  description = "Password du compte 'admin' de vCenter"
}


variable "FolderList" {
  type = map(any)
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
  for_each      = var.FolderList
  path          = "TFdemo/${each.value}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.my_dc.id
}

