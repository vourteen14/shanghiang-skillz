resource "google_compute_network" "vpc_angga" {
  name                    = "angga-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_angga" {
  name          = "angga-subnet"
  ip_cidr_range = "10.11.12.0/24"
  region        = var.region
  network       = google_compute_network.vpc_angga.id
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_angga.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}

resource "google_compute_firewall" "firewall_http" {
  name    = "allow-http"
  network = google_compute_network.vpc_angga.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}
