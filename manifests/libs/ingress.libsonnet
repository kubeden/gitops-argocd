local kube = import 'kube.libsonnet';
local helper = import 'helper.libsonnet';

{
  Ingress(p):: kube.Ingress(p.name) {
    metadata+: {
      annotations+: {
        'cert-manager.io/cluster-issuer': 'letsencrypt',
        'kubernetes.io/tls-acme': 'true',
      },
    },
    spec: {
      ingressClassName: 'nginx',
      rules: [
        {
          host: p.host,
          http: {
            paths: [
              {
                backend: {
                  service: {
                      name: p.name,
                      port: {
                        name: 'http'
                      },      
                  },
                },
                path: if std.objectHas(p, 'path') then p.path else '/',
                pathType: 'ImplementationSpecific',
              },
            ],
          },
        },
      ],
      tls: [
        {
          hosts: [
            p.host,
          ],
        },
      ],
    },
  },
}
