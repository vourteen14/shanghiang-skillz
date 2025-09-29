# Server Health Check & Disk Usage Check Script

## Usage
```bash
./health_check.sh <server> <port>
```

Parameters
- `server` => IP/hostname (required)
- `port` => Service port (default: 80)

Dependencies => `ping`, `curl`, `ssh`

## Technical Implementation

- Independent checks run regardless of previous failures for complete diagnostics
- Logging mode console output + timestamped log file

## SSH Setup
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id <SSH_REMOTE_USER>@<PUBLIC_IP>
```

If this setup sync with challenge 3, it should be use private keys from tofu output, by running command below

`gcloud secrets versions access latest --secret=<private key secret manager id> > /tmp/id_rsa && chmod 600 /tmp/id_rsa`

My recomendation is for use dedicated user for running the script and for making sure the single of truth to secure server access

```
mkdir -p <dedicated user home dir>/.ssh
sudo mv /tmp/id_rsa <dedicated user home dir>/.ssh/id_rsa
chown <dedicated user name>:<dedicated user group> <dedicated user home dir>/.ssh/id_rsa
chmod 600 <dedicated user home dir>/.ssh/id_rsa
```

## Output
```
Server is reachable.
Web service on port 80 is UP.
Disk usage on / is 55%.
Results logged to health_check.log
```
