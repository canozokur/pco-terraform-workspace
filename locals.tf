locals {
  shape   = "VM.Standard.A1.Flex"
  network = "10.0.0.0/16"
  subnet  = "10.0.0.0/16"
  image_id = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaxloe7grzdoamrmsm3eetkg34prf7rjqte5sewidrlfukaiurltta"
    eu-stockholm-1 = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaaxcefx34xbq2qqbqkzxzmva4jt5aqfd6xdchg7657hfpg7u7evdbq"
  }
}
