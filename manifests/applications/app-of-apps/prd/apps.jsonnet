local kube = import '../../../libs/kube.libsonnet';
local deploy = import '../../../libs/argocdDeploy.libsonnet';
local apps = import './my-applications.libsonnet';

local argocdApplications = {
  [p.name]: deploy.Application(p)
  for p in apps
};

kube.List(){items_+: argocdApplications}