{{- /*
  Renders spec.cassandra.datacenters array.
  Each element must follow the CRD shape (see k8ssandra docs).
*/ -}}
{{- define "k8ssandra.datacenters" -}}
{{- $root := . -}}
{{- range $i, $dc := .Values.datacenters }}
- metadata:
    name: {{ $dc.name | quote }}
    {{- with $dc.metadata }}
    {{- if .labels }}
    labels:
{{ toYaml .labels | nindent 6 }}
    {{- end }}
    {{- if .annotations }}
    annotations:
{{ toYaml .annotations | nindent 6 }}
    {{- end }}
    {{- end }}

  size: {{ $dc.size }} # The Number of Cassandra pods in this Datacenter.

  {{- if or $dc.racks (and (not $dc.racks) false) }}
  {{- if $dc.racks }}
  racks:
{{ toYaml $dc.racks | nindent 4 }}
  {{- end }}
  {{- end }}

  serverVersion: {{ $dc.serverVersion | default $root.Values.cassandra.serverVersion | quote }}

  {{- with $dc.storageConfig }}
  storageConfig: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.config }}
  config:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with $dc.nodeSelector }}
  nodeSelector:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with $dc.tolerations }}
  tolerations:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with $dc.affinity }}
  affinity:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with $dc.podSecurityContext }}
  podSecurityContext:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with $dc.managementApiAuth }}
  managementApiAuth:
{{ toYaml . | indent 4 }}
  {{- end }}
  {{- with $dc.mgmtAPIHeap }}
  mgmtAPIHeap: {{ . }}
  {{- end }}
  {{- if $dc.resources }}
  resources:
{{ toYaml $dc.resources | nindent 4 }}
  {{- else if $root.Values.cassandra.defaultResources }}
  # fallback to top-level defaultResources when datacenter-specific resources not provided
  resources:
{{ toYaml $root.Values.cassandra.defaultResources | nindent 4 }}
  {{- end }}
  {{- with $dc.telemetry }}
  telemetry:
{{ toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end -}}