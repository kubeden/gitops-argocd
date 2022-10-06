local globals = import 'globals.libsonnet';
local kube = import 'kube.libsonnet';

{
  Application(name, namespace='default'): kube._Object('argoproj.io/v1alpha1', 'Application', name) {
    local this = self,
    spec: {
      project: name,
      destination: {
        namespace: namespace,
        //server: error 'Spec/Destination/server must be set.',
      },
      source: {
        path: error 'Spec/Source/path must be set.',
        repoURL: error 'Spec/Source/repoURL must be set.',
        targetRevision: 'HEAD',
      },
      syncPolicy: {
        syncOptions: [
          'CreateNamespace=true',
        ],
      },
    },
  },

  //Use a custom Config Management Plugin - https://argoproj.github.io/argo-cd/user-guide/config-management-plugins/
  JsonnetHelmApplication(cluster, name, namespace):: $.Application(name, namespace) {
    spec+: {
      destination+: {
        name: cluster
      },
      source+: {
        plugin: {
          name: 'jsonnet-helm',
        },
      },
    },
  },

  // AppProject(name, server=globals.clusters.same, namespace='default'): kube._Object('argoproj.io/v1alpha1', 'AppProject', name) {
  //   local this = self,
  //   spec: {
  //     clusterResourceWhitelist: [
  //       {
  //         group: '*',
  //         kind: '*',
  //       },
  //     ],
  //     description: name,
  //     destinations: [
  //       {
  //         namespace: dest.namespace,
  //         server: if std.objectHas(dest, 'server') then dest.server else globals.clusters.same,
  //       }
  //       for dest in this.destinations_
  //     ],
  //     sourceRepos: [
  //       globals.gitrepos.kubeApplicationsState,
  //     ],
  //   },
  // },

  // AppOfAppsProject(name): kube._Object('argoproj.io/v1alpha1', 'AppProject', name) {
  //   local this = self,
  //   spec: {
  //     namespaceResourceBlacklist: [
  //       {
  //         group: 'bitnami.com',
  //         kind: 'SealedSecret',
  //       },
  //       {
  //         group: '*',
  //         kind: 'Secret',
  //       },
  //     ],
  //     clusterResourceWhitelist: [
  //       {
  //         group: 'argoproj.io',
  //         kind: 'Application',
  //       },
  //       {
  //         group: 'argoproj.io',
  //         kind: 'AppProject',
  //       },
  //     ],
  //     destinations: [
  //       {
  //         namespace: 'argocd',
  //         server: '',
  //       },
  //     ],
  //     orphanedResources: {
  //       warn: true,
  //     },
  //     sourceRepos: [
  //       '',
  //     ],
  //     description: name,
  //   },
  // },
}
