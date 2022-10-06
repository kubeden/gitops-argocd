local kube = import 'kube.libsonnet';

{
  ExternalSecret(name):: kube._Object('kubernetes-client.io/v1', 'ExternalSecret', name) {
  },

  ExternalSecretViaOperator(name):: kube._Object('external-secrets.io/v1alpha1', 'ExternalSecret', name) {
  },
}
