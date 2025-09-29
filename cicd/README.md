# CI/CD Pipeline, Charts, & Argo Application

## Structure

- Jenkinsfile => Pipeline for checkout, build, push, and update values.yaml for triggering ArgoCD Sync
- nextjs-charts/ => Helm chart for NextJS deployment, more simple, variable, and reusable than use regular kube manifest
- argocd/ => ArgoCD application for auto sync with helm values.yaml, make more easy to manage and documented infrastructure
- values.yaml => Helm values for used by ArgoCD, this file alaways change by Jenkins, more simple because we just need to replicate this for use in another env
- values.yaml.tpl => Helm values based template

## Jenkins Variable

Must setup these variable
```
- DOCKER_REGISTRY
  Type: Secret Text
  Example: registry.karuhun.dev (registry url)

- DOCKER_CREDENTIALS
  Type: Username with Password
  Username: registry username
  Password: registry password/token

- GIT_TOKEN
  Type: Secret Text
  Example: kjncdiaure... (git token for acccess repository, must have write access for jenkins commit purpose)

- INFRA_REPO
  Type: Secret Text
  Example: https://github.com/vourteen14/infra.git (infrastructure repository)
```

## Pipeline Flow

1. Build => Jenkins trigger on release, build, & push to registry
2. Registry => Pushes to registry with version tags
3. Deploy => Updates Helm values
4. GitOps => ArgoCD auto-sync the tags applied by Jenkins pipeline

Note, change on values.yaml will be replaced by jenkins, and don't change the values.yaml.tpl. it need to adjust the jenkins pipeline for replace the variable
