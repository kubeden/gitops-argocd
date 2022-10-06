{
  SkfDefaultService(p):: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: p.name,
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          name: 'http',
          port: 80,
          targetPort: p.containerPort,
        },
      ],
      selector: {
        app: p.name,
      },
    },
  },
}
