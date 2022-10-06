[
  {
    name: 'app-of-apps-mes',
    namespace: 'argocd',
    destination: 'in-cluster',
    path: 'xz98a/app-of-apps-mes/dev',
    project: 'default'
  },
  {
    name: 'hello-world-frontend',
    namespace: 'hello-world',
    destination: 'in-cluster',
    path: 'manifests/applications/hello-world/frontend',
    project: 'default'
  },
  {
    name: 'hello-world-backend',
    namespace: 'hello-world',
    destination: 'in-cluster',
    path: 'manifests/applications/hello-world/backend',
    project: 'default'
  },
]