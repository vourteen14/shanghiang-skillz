# OpenTofu GCP Infrastructure

## Architecture

- Compute => e2-micro Ubuntu 22.04 LTS instance
- Network => Custom VPC (10.0.0.0/16) with SSH/HTTP firewall rules
- Security => SSH keys stored in Google Secret Manager
- Region => us-central1 (configurable)

## Prerequisites

```bash
sudo snap install opentofu --classic

curl https://sdk.cloud.google.com | bash
exec -l $SHELL

gcloud auth login
gcloud auth application-default login
gcloud config set project <project-id>

gcloud services enable compute.googleapis.com
gcloud services enable secretmanager.googleapis.com
```

## Required IAM Roles

For non-owner users, project admin must grant

```bash
gcloud projects add-iam-policy-binding <project-id> --member="user:<dev@email.com>" --role="roles/compute.admin"

gcloud projects add-iam-policy-binding <project-id> --member="user:<dev@email.com>" --role="roles/compute.networkAdmin"

gcloud projects add-iam-policy-binding <project-id> --member="user:<dev@email.com>" --role="roles/secretmanager.admin"

gcloud projects add-iam-policy-binding <project-id> --member="user:<dev@email.com>" --role="roles/iam.serviceAccountUser"
```

## Deployment

```bash
tofu init

tofu plan -var="project_id=<project-id>"

tofu apply -var="project_id=<project-id> -auto-approve"
```

## SSH Access
```bash
gcloud secrets versions access latest --secret=<private key secret manager id> > /tmp/ssh_key && chmod 600 /tmp/ssh_key # (from tofu output)

ssh -i /tmp/ssh_private_key ubuntu@<PUBLIC_IP>
```

## HTTP Web access
```bash
curl http://<PUBLIC_IP>
```

## Destroy
```bash

tofu destroy -var="project_id=<project-id>"
```

## Technical Decisions

- Custom VPC => Enhanced security isolation vs default network
- Secret Manager => Secure SSH key storage, no version control exposure
- e2-micro => Cost optimization with Always Free tier eligibility
- Ubuntu 22.04 LTS => Long-term support and security updates
