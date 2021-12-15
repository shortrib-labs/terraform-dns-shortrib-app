locals {
  dns_name = "shortrib.app."
}

resource "google_dns_managed_zone" "shortrib_app" {
  name        = "shortrib-app"
  dns_name    = local.dns_name
  description = "Domain for shortrib applications and services"

  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "shortrib_app_caa" {
  name         = google_dns_managed_zone.shortrib_app.dns_name
  managed_zone = google_dns_managed_zone.shortrib_app.name
  type         = "CAA"
  ttl          = 300

  rrdatas = [
    "0 issue \"letsencrypt.org\""
  ]
}

resource "google_dns_record_set" "platform" {
  name         = "platform.${google_dns_managed_zone.shortrib_app.dns_name}"
  managed_zone = google_dns_managed_zone.shortrib_app.name
  type         = "CNAME"
  ttl          = 60

  rrdatas = [
    "osprod.crdant.io.beta.tailscale.net."
  ]
}

resource "google_dns_record_set" "kubernetes" {
  name         = "*.${google_dns_managed_zone.shortrib_app.dns_name}"
  managed_zone = google_dns_managed_zone.shortrib_app.name
  type         = "CNAME"
  ttl          = 60

  rrdatas = [
    "workload.crdant.io.beta.tailscale.net."
  ]
}
