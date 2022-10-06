local site = import '../site/site.libsonnet';

{
  Application(p):: {
    apiVersion: 'argoproj.io/v1alpha1',
    kind: 'Application',
    metadata: {
      name: p.name,
      namespace: 'argocd',
    },
    spec: {
      destination: {
        name: p.destination,
        namespace: p.namespace,
      },
      // project: 'default',
      project: if std.objectHas(p,'project') then p.project else 'default',
      source: {
        path: p.path,
        repoURL: site.configRepo,
        targetRevision: 'HEAD',
      },
      syncPolicy: {
        syncOptions: [
          'CreateNamespace=true',
        ],
      },
    },
  },
}
