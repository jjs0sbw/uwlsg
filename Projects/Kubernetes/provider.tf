provider "google" {
  credentials = "${file("service-account-credentials.json")}"
  project     = "uwsg-188622"
  region      = "us-west1-a"
}
