resource "oci_core_vcn" "default" {
  compartment_id = oci_identity_compartment.main.id

  cidr_block   = local.network
  display_name = "default"
}

resource "oci_core_internet_gateway" "default" {
  compartment_id = oci_identity_compartment.main.id

  vcn_id = oci_core_vcn.default.id
}

resource "oci_core_route_table" "default" {
  compartment_id = oci_identity_compartment.main.id
  vcn_id         = oci_core_vcn.default.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.default.id
  }
}

resource "oci_core_subnet" "default" {
  compartment_id = oci_identity_compartment.main.id

  cidr_block   = local.subnet
  display_name = "default"
  vcn_id       = oci_core_vcn.default.id
}

resource "oci_core_route_table_attachment" "default" {
  subnet_id      = oci_core_subnet.default.id
  route_table_id = oci_core_route_table.default.id
}
