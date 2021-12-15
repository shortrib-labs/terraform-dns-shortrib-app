terraform {
  backend "gcs" {
    bucket = "terraform-dns-shortrib-app"
    prefix = "terraform/state"
  }
}
