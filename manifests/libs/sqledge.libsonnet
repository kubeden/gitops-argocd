{
  WcmSqlEdge(p):: [
    {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        name: 'wcmsqledge-external',
        annotations: {
          'external-dns.alpha.kubernetes.io/hostname': p.hostname,
          ## Below will create an internal Load Balancer in Azure since we dont allow external load balancers.
          ## On hci, k3s etc this annotation will have no effect.
          'service.beta.kubernetes.io/azure-load-balancer-internal': 'true', 
        },
      },
      spec: {
        externalTrafficPolicy: 'Cluster',
        ports: [
          {
            name: 'hostport-1433-tcp',
            port: 1433,
            protocol: 'TCP',
            targetPort: 1433,
          },
        ],
        selector: {
          app: 'sqledge',
        },
        sessionAffinity: 'None',
        type: 'LoadBalancer',
      },
    },
    {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'sqledge-deployment',
      },
      spec: {
        replicas: 1,
        selector: {
          matchLabels: {
            app: 'sqledge',
          },
        },
        template: {
          metadata: {
            labels: {
              app: 'sqledge',
            },
          },
          spec: {
            volumes: [
              {
                name: 'sqldata',
                persistentVolumeClaim: {
                  claimName: 'sqledge-pvc',
                },
              },
            ],
            containers: [
              {
                name: 'azuresqledge',
                image: 'mcr.microsoft.com/azure-sql-edge:' + p.version,
                ports: [
                  {
                    containerPort: 1433,
                  },
                ],
                volumeMounts: [
                  {
                    name: 'sqldata',
                    mountPath: '/var/opt/mssql',
                  },
                ],
                env: [
                  {
                    name: 'MSSQL_PID',
                    value: 'Developer',
                  },
                  {
                    name: 'ACCEPT_EULA',
                    value: 'Y',
                  },
                  {
                    name: 'SA_PASSWORD',
                    valueFrom: {
                      secretKeyRef: {
                        name: 'mssql',
                        key: 'SA_PASSWORD',
                      },
                    },
                  },
                  {
                    name: 'MSSQL_AGENT_ENABLED',
                    value: 'TRUE',
                  },
                  {
                    name: 'MSSQL_COLLATION',
                    value: 'SQL_Latin1_General_CP1_CI_AS',
                  },
                  {
                    name: 'MSSQL_LCID',
                    value: '1033',
                  },
                ],
              },
            ],
            terminationGracePeriodSeconds: 30,
            securityContext: {
              fsGroup: 10001,
            },
          },
        },
      },
    },
    {
      apiVersion: 'external-secrets.io/v1alpha1',
      kind: 'ExternalSecret',
      metadata: {
        name: 'mssql',
      },
      spec: {
        data: [
          {
            remoteRef: {
              key: p.azureKeyVaultSecretName,
            },
            secretKey: 'SA_PASSWORD',
          },
        ],
        refreshInterval: '1h',
        secretStoreRef: {
          kind: 'ClusterSecretStore',
          name: 'azure-keyvault-same-site',
        },
        target: {
          creationPolicy: 'Owner',
          name: 'mssql',
        },
      },
    },
    {
      apiVersion: 'v1',
      kind: 'PersistentVolumeClaim',
      metadata: {
        annotations: {
          'volume.beta.kubernetes.io/storage-class': p.storageClass,
        },
        labels: {
          name: 'sqledge-pvc',
        },
        name: 'sqledge-pvc',
      },
      spec: {
        accessModes: [
          'ReadWriteOnce',
        ],
        resources: {
          requests: {
            storage: p.storageSize,
          },
        },
        storageClassName: p.storageClass,
      },
    },
  ],
}
