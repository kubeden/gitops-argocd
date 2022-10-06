(import '../params.libsonnet') {
  environment: 'dev',
  type: 'aks',

  docker+: {
    tag: 'sometag-39df4f',
  },
  host: 'hello-world.some-domain',

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

  env: {
    SOME_ENV_VAR: "SOME_VALUE"
  },
}
