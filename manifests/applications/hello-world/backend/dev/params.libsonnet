(import '../params.libsonnet') {
  environment: 'dev',
  type: 'aks',

  docker+: {
    tag: 'gitops-backend@sha256:44854d8a57493361144bf725e802b0002352d17e738b8c2bcb92f969245a9f33',
  },
  host: 'hello-world-backend.denctl.com',

  resources: {
    limits: {
      cpu: '200m',
      memory: '200Mi',
    },
    requests: {
      cpu: '100m',
      memory: '50Mi',
    },
  },
}
