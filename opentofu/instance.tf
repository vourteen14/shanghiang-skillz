
resource "google_compute_instance" "instance_angga" {
  name         = "instance-angga"
  machine_type = "e2-standard-2"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_angga.id
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.ssh_key.public_key_openssh}"
    startup-script = file("${path.module}/script/startup.sh")
  }

  tags = ["web"]

  service_account {
    scopes = ["cloud-platform"]
  }
}