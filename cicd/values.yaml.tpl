replicaCount: 1
image:
  repository: IMAGE
  pullPolicy: Always
  tag: TAG
imagePullSecrets: []
nameOverride: ""
fullnameOverride: ""
podAnnotations: {}
podLabels: {}
podSecurityContext: {}
securityContext: {}
service:
  type: ClusterIP
  port: 80
resources: {}
livenessProbe:
  httpGet:
    path: /
    port: http
readinessProbe:
  httpGet:
    path: /
    port: http
volumes: []
volumeMounts: []
nodeSelector: {}
tolerations: []
affinity: {}