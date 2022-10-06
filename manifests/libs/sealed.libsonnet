{
  SkfDefaultSealedSecret():: {
    apiVersion: 'bitnami.com/v1alpha1',
    kind: 'SealedSecret',
    metadata: {
      annotations: {
        'sealedsecrets.bitnami.com/cluster-wide': 'true',
      },
      name: 'regcred',
    },
    spec: {
      encryptedData: {
        '.dockerconfigjson': 'AgC77W2DNYBd3tdkGQ0HZgmRdYUFnpdFjukd77bqMyD+krA2UHh3+X/A4h3ypPXdZy+oSAN81VXDXBD+R6rxQpLg/L8l8hmslsO6o/T2YjaFQzbA5VvXHl3KQIg0qlwk7r78qSz3ljEEXOhWwyw5bwfU5/Zf2LbCNtRdUV+oyYeNv26s3F1OftP+z1hPzPTrAh05DCSaCYQaZeWbSMlpaUMexzkD7UINrD5bTRk5tErz/kc9udECtg4Dsv8f0bWO0NwxP6mzSZRi34shB+rRI4xUr+q5/PwpLWv3ZfOo8xuJMSRNL1mgcum1//pTpxqPLD+suUQkCBGAyjHOiCFfjSNUKWuDBoeQ2WIc+8lTj/o61bId6NkMcwPkoZxDzmRtxKXeEdij+9zYOSg9Ha9WmYNiCgq4cq9jPFDcLXG7yhhfne4U2FZEEcYjWqxPdnrB9x4k2N9aHGZFkLEXVQTp/Kk8bmlrtTcwzRW9vpueN5nPyIAR+YgIyhyFE7U0F0KlT+rqvFxdS4N+MptKKaAnLaEFgW3Fn8hbvZEZ7Gn1jchmB4rMljKVG5HSbgoYGoUGJGsodh825EoyxFg55eLNlJ4aqjoys0YkgfgMAvPSiXIodgOigVAFM2tVu5OwWdlpPjSjZP+k10NaEeFdSixQTV4JYu7YrtMOQJw1G+KHMhl8TAP3FTzO1/2DPYoGB3lXnLRCMhLe6FES/UrEDIiwNNrO2l+IUvIYxiSLZeQW4FyT7LBDx9tvqzdz42g5o1shibw3v8mXKx2ngvb9qhGIGi+88HSuB14nFePuXVZo7XeLh9+9f7WLmIuCiUanfOtjlCTdJXgiF0DJ9wtHflEY/3CPjR6im84XyDe9QzdFvtuhORZilmfRPsqPHpl8KyahK2+GxCOkTEW0pIXPgDCGcv2+bCOV9hh6NPgUE58UzVYXiMGNgQ==',
      },
      template: {
        metadata: {
          annotations: {
            'sealedsecrets.bitnami.com/cluster-wide': 'true',
          },
          name: 'regcred',
        },
        type: 'kubernetes.io/dockerconfigjson',
      },
    },
  },
}
