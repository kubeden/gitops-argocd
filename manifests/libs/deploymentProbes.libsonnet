local kube = import 'kube.libsonnet';
local helper = import 'helper.libsonnet';

local defaultReadinessProbe = {
  httpGet: { path: '/healthz', port: 'http' },
  initialDelaySeconds: 10,
  periodSeconds: 5,
  timeoutSeconds: 5,
};

local defaultLivenessProbe = {
  httpGet: { path: '/healthz', port: 80 },
  initialDelaySeconds: 0,
  periodSeconds: 10,
  timeoutSeconds: 1,
  failureThreshold: 3
};

local envFromConfigMap(d) =
  if std.objectHas(d, 'data') then
    {
      envFrom+: [
        {
          configMapRef: {
            name: helper.GetConfigMapName(d),
          },
        },
      ],
    }
  else
    {};

local envFromSecret(d) =
  if std.objectHas(d, 'encryptedData') then
    {
      envFrom+: [
        {
          secretRef: {
            name: helper.GetSealedSecretName(d),
          },
        },
      ],
    }
  else
    {};

local envFromExternalSecret(d) =
  if std.objectHas(d, 'externalSecrets') then
    {
      envFrom+: [
        {
          secretRef: {
            name: helper.GetExternalSecretName(d),
          },
        },
      ],
    }
  else
    {};

 local envVars(d) =
   if std.objectHas(d, 'envProbe') then
     {
       env_:: d.envProbe,
     }
   else
     {};

local envFrom(d) = envFromConfigMap(d) + envFromSecret(d) + envFromExternalSecret(d) + envVars(d) {
};

local Container(d) = kube.Container(d.nameProbe) + envFrom(d) {
  assert helper.IsString(d, 'nameProbe'),

  image: helper.FullDockerImageTag(d),
  ports_+: if std.objectHas(d, 'containerPort') then {
    http: { containerPort: d.containerPort },
  }
  else {},
  env_+: { CONTAINER_IMAGE_TAG: d.docker.tag },
  args: if std.objectHas(d, 'args') && std.isArray(d.args) then d.args else [],
  command: if std.objectHas(d, 'command') && std.isArray(d.command) then d.command else [],

  //readinessProbe: if std.objectHas(d, 'readinessProbe') then defaultReadinessProbe + d.readinessProbe else defaultReadinessProbe,
  livenessProbe: if std.objectHas(d, 'livenessProbe') then defaultLivenessProbe + d.livenessProbe else defaultLivenessProbe {},
};

{
  SkfDefaultDeployment(d):: kube.Deployment(d.nameProbe) +
                  helper.DefaultMetadata(d) {
                    assert helper.IsString(d, 'nameProbe'),
                    assert std.objectHasAll(d.autoscale, 'enabled'),
                    assert std.objectHas(d, 'resources'),

                    //If we have an autoscale object we want to remove the replicas field entirely. This is set per default to 1 in kube libsonnet.
                    local replicas = if d.autoscale.enabled then
                      { replicas:: null }
                    else if std.objectHas(d, 'replicas') && std.isNumber(d.replicas) then
                      { replicas: d.replicas }
                    else
                      error 'the field replicas or autoscale object must be set',

                    metadata+: {
                      labels+: {
                        app: d.nameProbe,
                      },
                    },
                    spec+: {
                      revisionHistoryLimit: 0,
                      template+: {

                        spec+: {
                          containers_+: {
                            default_container: Container(d) {
                              resources: d.resources,
                            },
                          },
                          imagePullSecrets: [
                              {
                                name: 'skfxz98aacr',
                              },
                            ]
                            // imagePullSecrets: if d.type == 'hci' || d.type == 'k3s' then [
                            //   {
                            //     name: 'skfxz98aacr',
                            //   },
                            // ] else [],

                        } + if std.objectHas(d, 'initContainers') then {
                          initContainers_+: d.initContainers,
                        }
                        else {},
                      },
                    } + replicas,
                  },
}
