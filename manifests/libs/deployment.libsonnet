local kube = import 'kube.libsonnet';
local helper = import 'helper.libsonnet';

local envFromConfigMap(p) =
  if std.objectHas(p, 'data') then
    {
      envFrom+: [
        {
          configMapRef: {
            name: helper.GetConfigMapName(p),
          },
        },
      ],
    }
  else
    {};

local envFromSecret(p) =
  if std.objectHas(p, 'encryptedData') then
    {
      envFrom+: [
        {
          secretRef: {
            name: helper.GetSealedSecretName(p),
          },
        },
      ],
    }
  else
    {};

local envVars(p) =
  if std.objectHas(p, 'env') then
    {
      env_:: p.env,
    }
  else
    {};

local envFrom(p) = envFromConfigMap(p) + envFromSecret(p) + envVars(p) {
};

local Container(p) = kube.Container(p.name) + envFrom(p) {
  assert helper.IsString(p, 'name'),

  image: helper.FullDockerImageTag(p),
  ports_+: if std.objectHas(p, 'containerPort') then {
    http: { containerPort: p.containerPort },
  }
  else {},
  env_+: { CONTAINER_IMAGE_TAG: p.docker.tag },
  args: if std.objectHas(p, 'args') && std.isArray(p.args) then p.args else [],
  command: if std.objectHas(p, 'command') && std.isArray(p.command) then p.command else [],

  // readinessProbe: if std.objectHas(p, 'readinessProbe') then defaultReadinessProbe + p.readinessProbe else defaultReadinessProbe,
  // livenessProbe: if std.objectHas(p, 'livenessProbe') then p.livenessProbe else {},
};

{
  Deployment(p):: kube.Deployment(p.name) +
                  helper.DefaultMetadata(p) {
                    assert helper.IsString(p, 'name'),
                    assert std.objectHasAll(p.autoscale, 'enabled'),
                    assert std.objectHas(p, 'resources'),

                    //If we have an autoscale object we want to remove the replicas field entirely. This is set per default to 1 in kube libsonnet.
                    local replicas = if p.autoscale.enabled then
                      { replicas:: null }
                    else if std.objectHas(p, 'replicas') && std.isNumber(p.replicas) then
                      { replicas: p.replicas }
                    else
                      error 'the field replicas or autoscale object must be set',

                    metadata+: {
                      labels+: {
                        app: p.name,
                      },
                    },
                    spec+: {
                      revisionHistoryLimit: 0,
                      template+: {

                        spec+: {
                          containers_+: {
                            default_container: Container(p) {
                              resources: p.resources,
                            },
                          },
                          imagePullSecrets: [
                              {
                                name: 'registry-denctl',
                              },
                            ]

                        } + if std.objectHas(p, 'initContainers') then {
                          initContainers_+: p.initContainers,
                        }
                        else {},
                      },
                    } + replicas,
                  },
}
