{{- /*
  Renders spec.cassandra.datacenters array.
  Each element must follow the CRD shape (see k8ssandra docs).
*/ -}}
{{- define "k8ssandra.datacenters" -}}
{{- range $i, $dc := .Values.datacenters }}
- metadata:
    name: {{ $dc.name | quote }}
    {{- with $dc.metadata }}
    {{- if .labels }}
    labels: {{ toYaml .labels | nindent 6 }}
    {{- end }}
    {{- if .annotations }}
    annotations: {{ toYaml .annotations | nindent 6 }}
    {{- end }}
    {{- end }}
  size: {{ $dc.size }} # The Number of Cassandra pods in this Datacenter.
  {{- if or $dc.racks (and (not $dc.racks) false) }}
  {{- if $dc.racks }}
  racks: {{ toYaml $dc.racks | nindent 4 }}
  {{- end }}
  {{- end }}
  serverVersion: {{ $dc.serverVersion | default $.Values.cassandra.serverVersion | quote }}

  {{- with $dc.persistence }}
  storageConfig:
    cassandraDataVolumeClaimSpec:
      {{- if .storageClassName }}
      storageClassName: {{ .storageClassName }}
      {{- end }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ .size }}
  {{- end }}

  {{- with $dc.config }}
  config: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.nodeSelector }}
  nodeSelector: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.tolerations }}
  tolerations: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.affinity }}
  affinity: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.podSecurityContext }}
  podSecurityContext: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.managementApiAuth }}
  managementApiAuth: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.mgmtAPIHeap }}
  mgmtAPIHeap: {{ . }}
  {{- end }}
  
  {{- with $dc.resources }}
  resources: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with $dc.telemetry }}
  telemetry: {{ toYaml . | nindent 4 }}
  {{- end }}

{{- end }}
{{- end -}}