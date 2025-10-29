{{- /*
  Render the `reaper` spec under K8ssandraCluster.spec.reaper,
  aligned with the CRD (latest) fields:
  - serviceAccountName
  - affinity
  - autoScheduling.enabled
  - cassandraUserSecretRef
  - containerImage
  - deploymentMode
  - heapSize
  - httpManagement
  - keyspace
  - livenessProbe / readinessProbe
  - metadata (labels, annotations)
  - podSecurityContext
  - resources
  - secretsProvider
  - securityContext
  - telemetry
  - tolerations
*/ -}}
{{- define "k8ssandra.reaper" -}}
{{- $root := . -}}
reaper:
  {{- with .Values.reaper.serviceAccountName }}
  serviceAccountName: {{ . | quote }}
  {{- end }}
  {{- with .Values.reaper.affinity }}
  affinity:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.autoScheduling }}
  autoScheduling:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.cassandraUserSecretRef }}
  cassandraUserSecretRef:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.containerImage }}
  containerImage:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.deploymentMode }}
  deploymentMode: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.heapSize }}
  heapSize: {{ . }}
  {{- end }}

  {{- with .Values.reaper.httpManagement }}
  httpManagement:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.keyspace }}
  keyspace: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.livenessProbe }}
  livenessProbe:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.readinessProbe }}
  readinessProbe:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.metadata }}
  metadata:
    {{- if .labels }}
    labels:
{{ toYaml .labels | indent 6 }}
    {{- end }}
    {{- if .annotations }}
    annotations:
{{ toYaml .annotations | indent 6 }}
    {{- end }}
  {{- end }}

  {{- with .Values.reaper.podSecurityContext }}
  podSecurityContext:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.resources }}
  resources:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.secretsProvider }}
  secretsProvider: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.securityContext }}
  securityContext:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.telemetry }}
  telemetry:
{{ toYaml . | indent 4 }}
  {{- end }}

  {{- with .Values.reaper.tolerations }}
  tolerations:
{{ toYaml . | indent 4 }}
  {{- end }}

{{- end }}
