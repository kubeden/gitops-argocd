(import '../params.libsonnet') {
  environment: 'dev',
  type: 'aks',

  docker+: {
    tag: 'gitops-backend@sha256:699f088140ebc979ec5e907a4b2769cac8604b83f5940ab436339551070433ef',
  },
  host: 'demo-world-backend.denctl.com',

  resources: {
    limits: {
      cpu: '50m',
      memory: '50Mi',
    },
    requests: {
      cpu: '50m',
      memory: '50Mi',
    },
  },
}
