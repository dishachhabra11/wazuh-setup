terraform {
  backend "gcs" {
    bucket = "wazuh-bucket-129"
    prefix = "terraform/state"
  }
}
