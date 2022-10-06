[
  {
    name: 'app-of-apps-mes',
    namespace: 'argocd',
    destination: 'in-cluster',
    path: 'xz98a/app-of-apps-mes/prd',
    project: 'default'
  },
  {
    name: 'mes-frontend',
    namespace: 'mes',
    destination: 'in-cluster',
    path: 'xz98a/mes/mes-frontend/prd',
    project: 'mes'
  },
  {
    name: 'mes-backend',
    namespace: 'mes',
    destination: 'in-cluster',
    path: 'xz98a/mes/mes-backend/prd',
    project: 'mes'
  },
]