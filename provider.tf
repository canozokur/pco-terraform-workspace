terraform {
  required_version = "~> 1.9"

  cloud {
    organization = "pco"

    workspaces {
      name = "pco-terraform-workspace"
    }
  }

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.15"
    }
  }
}

variable "oci_private_key" {
  type = string
}

variable "oci_tenancy_ocid" {
  type = string
}

variable "oci_fingerprint" {
  type = string
}

variable "oci_region" {
  type = string
}

variable "oci_user_ocid" {
  type = string
}

provider "oci" {
  auth         = "APIKey"
  tenancy_ocid = var.oci_tenancy_ocid
  user_ocid    = var.oci_user_ocid
  private_key  = var.oci_private_key
  fingerprint  = var.oci_fingerprint
  region       = var.oci_region
}

provider "random" {
}
