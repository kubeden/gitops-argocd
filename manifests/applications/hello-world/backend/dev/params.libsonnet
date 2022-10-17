(import '../params.libsonnet') {
  environment: 'dev',
  type: 'aks',

  docker+: {
    tag: 'sometag-293ffs9',
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

  livenessProbe: {
    httpGet: {
      path: '/ready',
      port: 'http'
    },
    initialDelaySeconds: 60,
    periodSeconds: 5,
    timeoutSeconds: 5
  },

  readinessProbe: {
    httpGet: {
      path: '/healthz/',
      port: 'http'
    },
    initialDelaySeconds: 60,
    periodSeconds: 5,
    timeoutSeconds: 5
  },

  env: {
    SOME_ENV_VAR: "some value",
  },
}
