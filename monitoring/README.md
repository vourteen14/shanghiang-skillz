# Monitoring & Alerting (Out-of-challenge)

## Architecture
```
Node Exporter (9100) → Prometheus (9090) → Alertmanager (9093)
```

Components
- Prometheus => Metrics collection and alert rule evaluation
- Node Exporter => System metrics exposure (disk, CPU, memory)
- Alertmanager => Alert routing and notifications

## Alert Configuration

- P3 (Warning) => >70% disk usage, 2min duration - allows proactive intervention escalation >1 day
- P1 (Critical) => >90% disk usage, 1min duration - emergency notification must be executed immedietelly escalation >15 mins

## Deployment

```bash
docker-compose up -d prometheus node-exporter alertmanager

promtool check rules alert-manager.yml
curl localhost:9100/metrics | grep filesystem
```