data "oci_identity_availability_domains" "all" {
  compartment_id = oci_identity_compartment.main.id
}

locals {
  availability_domains = [for i in data.oci_identity_availability_domains.all.availability_domains : i.name]
}

resource "random_shuffle" "ad" {
  input        = local.availability_domains
  result_count = 1
}

data "oci_core_images" "img" {
  compartment_id = oci_identity_compartment.main.id

  operating_system = "Canonical Ubuntu"
  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-24.04-Minimal-([\\.0-9-]+)$"]    
    regex  = true
  }
  shape        = local.shape
  state        = "AVAILABLE"
}

resource "oci_core_instance" "pco-k8s-node" {
  compartment_id      = oci_identity_compartment.main.id
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
    source_id               = one(data.oci_core_images.img.images).id
    source_type             = "image"
  }

  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCk/uh6KjUB8wNwLawPdZyJ9AcN0aHjspZuukQcsI773s1ghy5U4Wlhx+FEeUsZzBEcMRGf8bZzyvhb57H8B/lA7W4wz9TfLHAPu2OqE2Lu8anxqebCmjSchvfckefHe7B/J0oUtyhqOyw5+DPvi8HSbIh5/oxQqwweUGl9nqmhLZj883fnGYGsvoSKHmkuh2PpSLZQng8cGGAR7/1wakIR8XWMmDt7k+AYrTuSihJLpgiWgexZ2mTcVuEpJhhi2nC/0lKly4Czvg/EuKHDMocV0dJz8/1CVxlpO7oQvPMx4x1aPZQqUNYqmv60Voc33xM4Qg7dv4I371O/tOHAew7V"
  }
}
