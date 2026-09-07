locals {
  shape   = "VM.Standard.A1.Flex"
  network = "10.0.0.0/16"
  subnet  = "10.0.0.0/16"
  image_id = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaawwulrgpbabqztutg53jurdo7l2rciundmbg544hfh7k4t2wcokaq"
    eu-stockholm-1 = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaayld52ddzfjc4f677rc7f34hiti2xzfc4tip2ikn7l6q6lmmkofna"
  }
}
