local deployment = import 'deployment.libsonnet';
local ingress = import 'ingress.libsonnet';
local kube = import 'kube.libsonnet';
local service = import 'service.libsonnet';

{
  SimpleApp(p):: {
    ingress: ingress.Ingress(p),
    deployment: deployment.Deployment(p),
    service: service.Service(p),
  }
}
