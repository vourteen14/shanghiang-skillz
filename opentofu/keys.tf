resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "google_secret_manager_secret" "ssh_private_key" {
  secret_id = "ssh-private-key-${random_id.suffix.hex}"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_private_key" {
  secret      = google_secret_manager_secret.ssh_private_key.id
  secret_data = tls_private_key.ssh_key.private_key_pem
}

resource "google_secret_manager_secret" "ssh_public_key" {
  secret_id = "ssh-public-key-${random_id.suffix.hex}"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_public_key" {
  secret      = google_secret_manager_secret.ssh_public_key.id
  secret_data = tls_private_key.ssh_key.public_key_openssh
}

resource "random_id" "suffix" {
  byte_length = 4
}