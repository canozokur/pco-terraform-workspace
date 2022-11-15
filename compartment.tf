resource "oci_identity_compartment" "main" {
  compartment_id = var.oci_tenancy_ocid
  description    = "Main compartment"
  name           = "main"
}
