local helper = import 'helper.libsonnet';
local kube = import 'kube.libsonnet';
local kubeExt = import 'kubeExtensions.libsonnet';

{
  ExternalSecret(p):: kubeExt.ExternalSecretViaOperator(helper.GetExternalSecretName(p)) {

    spec: {
      refreshInterval: '1h',
      secretStoreRef: {
        kind: 'ClusterSecretStore',
        name: 'azure-keyvault-same-site',
      },
      target: {
        creationPolicy: 'Owner',
        name: helper.GetExternalSecretName(p),
      },

      local this = self,

      envList(map):: [
        {
          remoteRef: {
            key: if map[x] == null then null else std.toString(map[x]),
          },
          secretKey: x,
          // Let `null` value stay as such (vs string-ified)
          // name: x,
          // key: if map[x] == null then null else std.toString(map[x]),
          // property: 'value',
        }
        for x in std.objectFields(map)
      ],

      data: this.envList(p.externalSecrets.data),
    },
  },
}
