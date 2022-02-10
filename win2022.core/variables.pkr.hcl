
variable "os_iso_path" {
  type    = string
  default = "[yourdatastore] path/Server 2022/server2022.ISO"
}

variable "vmtools_iso_path" {
  type    = string
  default = "[yourdatastore] path/vmtools/windows.ISO"
}

variable "vm-cpu-num" {
  type    = string
  default = "4"
}

variable "vm-disk-size" {
  type    = string
  default = "40960"
}

variable "vm-mem-size" {
  type    = string
  default = "4096"
}

variable "vm-name" {
  type    = string
  default = "Win2022-Core-Template-Base"
}

variable "vsphere-cluster" {
  type    = string
  default = "yourcluster"
}

variable "vsphere-datacenter" {
  type    = string
  default = "yourdatacenter"
}

variable "vsphere-datastore" {
  type    = string
  default = "yourdatastore"
}

variable "vsphere-folder" {
  type    = string
  default = "templates"
}

variable "vsphere-network" {
  type    = string
  default = "yourportgroup"
}

variable "vsphere-password" {
  type    = string
  default = "Ch@ng3m3!"
}

variable "vsphere-server" {
  type    = string
  default = "vcenter1.changeme.local"
}

variable "vsphere-user" {
  type    = string
  default = "Change.Me@vsphere.local"
}

variable "winadmin-password" {
  type    = string
  default = "packer" // also declared in the autounattend.xml. If you want to change this, change it in both places. 
}