packer {
  required_version = ">= 0.0.1"
  required_plugins {
    windows-update = {
      version = ">= 0.14.1"
      source = "github.com/rgl/windows-update"
    }
  }
}

source "vsphere-iso" "server-2022-core" {
  CPUs                  = "${var.vm-cpu-num}"
  RAM                   = "${var.vm-mem-size}"
  cluster               = "${var.vsphere-cluster}"
  communicator          = "winrm"
  convert_to_template   = "true"
  datacenter            = "${var.vsphere-datacenter}"
  datastore             = "${var.vsphere-datastore}"
  disk_controller_type  = ["lsilogic-sas"]
  storage {
    disk_size = "${var.vm-disk-size}"
    disk_thin_provisioned = true
    }
  firmware              = "efi-secure"
  floppy_files          = ["./win2022.core/autounattend.xml", "./scripts/disable-network-discovery.cmd", "./scripts/enable-rdp.cmd", "./scripts/enable-winrm.ps1", "./scripts/install-vm-tools.cmd", "./scripts/set-temp.ps1"]
  folder                = "${var.vsphere-folder}"
  guest_os_type         = "windows2019srvNext_64Guest"
  insecure_connection   = "true"
  iso_paths             = ["${var.os_iso_path}", "${var.vmtools_iso_path}"]
  network_adapters {
    network = "${var.vsphere-network}"
    network_card = "vmxnet3"
  }
  password              = "${var.vsphere-password}"
  username              = "${var.vsphere-user}"
  vcenter_server        = "${var.vsphere-server}"
  vm_name               = "${var.vm-name}"
  winrm_password        = "${var.winadmin-password}"
  winrm_username        = "Administrator"
  winrm_use_ssl         = "false"
  winrm_insecure        = "true"
  boot_command          = ["<spacebar>"]
  boot_wait             = "1s"
  remove_cdrom          = true
}

build {
  sources = ["source.vsphere-iso.server-2022-core"]

  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
  }
  provisioner "windows-restart" {
    max_retries = 6
  }
}
