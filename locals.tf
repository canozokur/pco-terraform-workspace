locals {
  operating_system         = "Canonical Ubuntu" # nobody calls it "Canonical Ubuntu", come on Oracle :(
  operating_system_version = "22.04 Minimal aarch64"
  shape                    = "VM.Standard.A1.Flex"
  network                  = "10.0.0.0/16"
  subnet                   = "10.0.0.0/16"
}
