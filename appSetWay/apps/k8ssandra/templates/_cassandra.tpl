{{- /*
  Render cluster-level cassandra spec according to K8ssandraCluster.spec.cassandra
  - Uses $.Values.cassandra for cluster defaults
  - Datacenters are rendered by k8ssandra.datacenters (below)
*/ -}}
{{- define "k8ssandra.cassandra" -}}
clusterName: {{ .Values.cassandra.clusterName | default $.Values.clusterName | quote }}
serverVersion: {{ .Values.cassandra.serverVersion | default .Values.cassandra.version | quote }}
{{- with .Values.cassandra.softPodAntiAffinity }}
softPodAntiAffinity: {{ . }}
{{- end }}
{{- with .Values.cassandra.metadata }}
metadata:
  {{- if .labels }}
{{ toYaml . | indent 2 }}
  {{- end }}
  {{- if .annotations }}
{{ toYaml . | indent 2 }}
  {{- end }}
  {{- if .commonLabels }}
{{ toYaml . | indent 2 }}
  {{- end }}
  {{- if .commonAnnotations }}
{{ toYaml . | indent 2 }}
  {{- end }}
  {{- end }}

{{- with .Values.cassandra.config }}
config:
  {{- if .cassandraYaml }}
  cassandraYaml:
{{ toYaml . | nindent 4 }}
  {{- end }}
  {{- if .jvmOptions }}
  jvmOptions:
{{ toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- with .Values.cassandra.managementApiAuth }}
managementApiAuth:
{{ toYaml . | indent 2 }}
{{- end -}}

{{- with .Values.cassandra.mgmtAPIHeap }}
mgmtAPIHeap: {{ . }}
{{- end }}

{{- with .Values.cassandra.podSecurityContext }}
podSecurityContext:
{{ toYaml . | indent 2 }}
{{- end }}

{{- with .Values.cassandra.resources }}
# top-level default resources (still per-DC overrides possible)
resources:
{{ toYaml . | indent 2 }}
{{- end }}

{{- if .Values.cassandra.telemetry }}
telemetry: {{ toYaml .Values.cassandra.telemetry | nindent 2 }}
{{- else if .Values.prometheus.enabled }}
telemetry:
  prometheus:
    enabled: true
  mcac:
    enabled: false
{{- end }}

{{- with .Values.cassandra.persistence }}
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

{{- with .Values.cassandra.tolerations }}
tolerations:
{{ toYaml . | indent 2 }}
{{- end }}

{{- with .Values.cassandra.clientEncryptionStores }}
clientEncryptionStores:
{{ toYaml . | indent 2 }}
{{- end }}

{{- with .Values.cassandra.serverEncryptionStores }}
serverEncryptionStores:
{{ toYaml . | indent 2 }}
{{- end }}

{{- with .Values.cassandra.superuserSecretRef }}
superuserSecretRef:
{{ toYaml . | indent 2 }}
{{- end }}

datacenters: {{ include "k8ssandra.datacenters" . | indent 2 }}
{{- end -}}