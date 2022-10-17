{
  local this = self,

  ObjectValues(o):: [o[field] for field in std.objectFields(o)],

  IsType(p, value, type)::
    assert std.objectHas(p, value) : value + ' is needed as a ' + type;
    assert std.type(p[value]) == type : std.trace(std.toString(p[value]), value + ' must be set as a ' + type);
    true,

  IsString(p, value)::
    assert this.IsType(p, value, 'string');
    true,

  IsNumber(p, value)::
    assert this.IsType(p, value, 'number');
    true,

  IsArray(p, value)::
    assert this.IsType(p, value, 'array');
    true,

  IsObject(p, value)::
    assert this.IsType(p, value, 'object');
    true,

  FullDockerImageTag(p)::
    assert std.isString(p.name) : 'the name variable must be set as a string';
    assert std.objectHas(p, 'docker') : 'the docker variable must be set as an object with image and tag';
    assert std.isObject(p.docker) : 'the docker variable must be set as an object with image and tag';
    assert std.isString(p.docker.tag) : 'the docker.tag variable must be set as a string';
    assert std.isString(p.docker.image) : 'the docker.image variable must be set as a string';
    p.docker.image + '/' + p.docker.tag,

  DefaultMetadata(p):: {
    assert this.IsString(p, 'name'),
    assert this.IsString(p, 'contact'),
    assert this.IsString(p, 'product'),
    metadata+: {
      labels+: {
        'contact': p.contact,
        'app.kubernetes.io/name': p.name,
      },
      annotations+: {
        'product': p.product,
      },
    },
  },

  GetCronJobName(p)::
    if this.IsString(p, 'name') then p.name,
  GetJobName(p)::
    if this.IsString(p, 'name') then p.name,
  GetConfigMapName(p)::
    if this.IsString(p, 'name') then p.name,
  GetSecretName(p)::
    if this.IsString(p, 'name') then p.name,
  GetSealedSecretName(p)::
    if this.IsString(p, 'name') then p.name + '-sealed',
  GetServiceName(p)::
    if this.IsString(p, 'name') then p.name,
  GetPreviewServiceName(p)::
    if this.IsString(p, 'name') then p.name + '-preview',
  GetNamespaceName(p)::
    if std.objectHas(p, 'namespace') && std.isString(p.namespace) then p.namespace,

  EnvironmentIsOk(p)::
    assert this.IsString(p, 'environment');
    if p.environment != 'dev' && p.environment != 'prd'  then
      error 'environment must be dev or prd'
    else
      true,
}
