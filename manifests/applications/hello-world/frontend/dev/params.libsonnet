(import '../params.libsonnet') {
  environment: 'dev',
  type: 'doks',

  docker+: {
    tag: 'gitops-frontend@sha256:c05b6a6dcadf054525defca6798e8103c20482d924b89249ccbe7eda778ffe1a',
  },
  host: 'hello-world.denctl.com',

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
