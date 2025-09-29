output "instance_name" {
  description = "Instance Name"
  value       = google_compute_instance.instance_angga.name
}

output "web_server_url" {
  description = "Web Server URL"
  value       = "http://${google_compute_instance.instance_angga.network_interface.0.access_config.0.nat_ip}"
}

output "ssh_private_key_secret" {
  description = "Private SSH key secret name in Secret Manager"
  value       = google_secret_manager_secret.ssh_private_key.secret_id
}

output "ssh_public_key_secret" {
  description = "Public SSH key secret name in Secret Manager"
  value       = google_secret_manager_secret.ssh_public_key.secret_id
}

output "get_ssh_key_command" {
  description = "Command to retrieve SSH private key from Secret Manager"
  value       = "gcloud secrets versions access latest --secret=${google_secret_manager_secret.ssh_private_key.secret_id} > /tmp/ssh_key && chmod 600 /tmp/ssh_key"
}

output "ssh_remote_command" {
  description = "SSH into the instance"
  value       = "ssh -i /tmp/ssh_key -o StrictHostKeyChecking=no ubuntu@${google_compute_instance.instance_angga.network_interface.0.access_config.0.nat_ip}"
}