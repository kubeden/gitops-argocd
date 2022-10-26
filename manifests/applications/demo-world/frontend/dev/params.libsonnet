(import '../params.libsonnet') {
  environment: 'dev',
  type: 'doks',

  docker+: {
    tag: 'gitops-frontend@sha256:213a453866e67dcbfed51b21c4ad5c18a7290da79b1d1731407d83f6432f1681',
  },
  host: 'demo-world.denctl.com',

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
