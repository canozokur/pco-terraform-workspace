data "oci_identity_availability_domains" "all" {
  compartment_id = var.oci_tenancy_ocid
}

locals {
  availability_domains = [for i in data.oci_identity_availability_domains.all.availability_domains : i.name]
}

resource "random_shuffle" "ad" {
  input        = local.availability_domains
  result_count = 1
}

data "oci_core_images" "img" {
  compartment_id = var.oci_tenancy_ocid

  operating_system         = local.operating_system
  operating_system_version = local.operating_system_version
}

resource "oci_core_vcn" "default" {
  compartment_id = var.oci_tenancy_ocid

  cidr_block   = local.network
  display_name = "default"
}

resource "oci_core_subnet" "default" {
  compartment_id = var.oci_tenancy_ocid

  cidr_block   = local.subnet
  display_name = "default"
  vcn_id       = oci_core_vcn.default.id
}

resource "oci_core_instance" "pco-k8s-node" {
  compartment_id      = var.oci_tenancy_ocid
  availability_domain = element(random_shuffle.ad.result, 0)
  shape               = local.shape
  shape_config {
    ocpus         = 4
    memory_in_gbs = 24
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.default.id
  }

  source_details {
    boot_volume_size_in_gbs = 200
    source_id               = data.oci_core_images.img.id
    source_type             = "bootVolume"
  }
}
