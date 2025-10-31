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

{{- if .Values.cassandra.podSecurityContext }}
podSecurityContext: {{ toYaml .Values.cassandra.podSecurityContext | nindent 2 }}
{{- else }}
podSecurityContext:
  fsGroup: 999
  runAsGroup: 999
  runAsUser: 999
  runAsNonRoot: true
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

{{- if .Values.cassandra.initContainers }}
initContainers: {{ toYaml .Values.cassandra.initContainers | nindent 2 }}
{{- else }}
initContainers:
  - name: server-config-init-base
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      privileged: false
      capabilities:
        drop:
        - ALL
        - CAP_NET_RAW
  - name: server-config-init
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      privileged: false
      capabilities:
        drop:
        - ALL
        - CAP_NET_RAW
{{- end }}

{{- if .Values.cassandra.containers }}
containers: {{ toYaml .Values.cassandra.containers | nindent 2 }}
{{- else }}
containers:
  - name: cassandra
    securityContext:
      allowPrivilegeEscalation: false
      #readOnlyRootFilesystem: true
      privileged: false
      capabilities:
        drop:
        - ALL
        - CAP_NET_RAW
  - name: server-system-logger
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      privileged: false
      capabilities:
        drop:
        - ALL
        - CAP_NET_RAW
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