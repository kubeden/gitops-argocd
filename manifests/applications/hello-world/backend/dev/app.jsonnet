local kube = import '../../../../libs/kube.libsonnet';
local applications = import '../../../../libs/applications.libsonnet';
local p = import 'params.libsonnet';

local all = applications.SimpleApp(p);

kube.List(){items_: all}

