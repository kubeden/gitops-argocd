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
    path: 'manifests/applications/hello-world/frontend/dev',
    project: 'default'
  },
  {
    name: 'hello-world-backend',
    namespace: 'hello-world',
    destination: 'in-cluster',
    path: 'manifests/applications/hello-world/backend/dev',
    project: 'default'
  },
  {
    name: 'demo-world-frontend',
    namespace: 'demo-world',
    destination: 'in-cluster',
    path: 'manifests/applications/demo-world/frontend/dev',
    project: 'default'
  },
  {
    name: 'demo-world-backend',
    namespace: 'demo-world',
    destination: 'in-cluster',
    path: 'manifests/applications/demo-world/backend/dev',
    project: 'default'
  }
]