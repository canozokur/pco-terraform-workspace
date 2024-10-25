locals {
  shape   = "VM.Standard.A1.Flex"
  network = "10.0.0.0/16"
  subnet  = "10.0.0.0/16"
  image_id = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaapb65ywn23pl6t6dzc2bk56k4azbvnmsndcr6bfmn5eoei5toc53a"
    eu-stockholm-1 = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaavni5omi3qljq5umzlymbzxdczn3cmvgnfwb4tdfsls6qyehlv43q"
  }
}
