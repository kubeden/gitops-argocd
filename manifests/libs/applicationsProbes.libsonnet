local deployment = import 'deployment.libsonnet';
local deploymentProbes = import 'deploymentProbes.libsonnet';
local externalSecrets = import 'externalSecrets.libsonnet';
local ingress = import 'ingress.libsonnet';
local kube = import 'kube.libsonnet';
local service = import 'service.libsonnet';

{
  SimpleApp(p):: {
                         ingress: ingress.Ingress(p),
                         // deployment: deployment.SkfDefaultDeployment(p),
                         deploymentProbe: deploymentProbes.SkfDefaultDeployment(p),
                         service: service.SkfDefaultService(p),

                       } +
                       if std.objectHas(p, 'externalSecrets') then { externalSecret: externalSecrets.ExternalSecret(p) } else {},

}
