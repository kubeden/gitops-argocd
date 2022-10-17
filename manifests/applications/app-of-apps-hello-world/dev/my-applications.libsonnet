[
  {
    name: 'app-of-apps-hello-world',
    namespace: 'argocd',
    destination: 'in-cluster',
    path: 'manifests/applications/app-of-apps-hello-world/dev',
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