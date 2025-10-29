{{- /*
  Render the `medusa` spec under K8ssandraCluster.spec.medusa,
  aligned with CRD / docs:

  - storageProperties
  - cassandraUserSecretRef
  - resources, env, tolerations, affinity, podSecurityContext, securityContext
  - metadata (optional)
*/ -}}
{{- define "k8ssandra.medusa" -}}
medusa:
  {{- with .Values.medusa.cassandraUserSecretRef }}
  cassandraUserSecretRef:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.storageProperties }}
  storageProperties:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.metadata }}
  metadata:
    {{- if .labels }}
    labels:
{{ toYaml .labels | nindent 6 }}
    {{- end }}
    {{- if .annotations }}
    annotations:
{{ toYaml .annotations | nindent 6 }}
    {{- end }}
  {{- end }}

  {{- with .Values.medusa.podSecurityContext }}
  podSecurityContext:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.securityContext }}
  securityContext:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.affinity }}
  affinity:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.tolerations }}
  tolerations:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.resources }}
  resources:
{{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.medusa.env }}
  env:
{{ toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
