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
  {{- with .Values.reaper.metadata }}
  metadata:
    {{- if .labels }}
    labels: {{ toYaml .labels | nindent 6 }}
    {{- end }}
    {{- if .annotations }}
    annotations: {{ toYaml .annotations | nindent 6 }}
    {{- end }}
  {{- end }}

  {{- with .Values.reaper.serviceAccountName }}
  serviceAccountName: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.affinity }}
  affinity: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- if .Values.reaper.autoScheduling }}
  autoScheduling: {{ toYaml .Values.reaper.autoScheduling | nindent 4 }}
  {{- else }}
  autoScheduling:
    enabled: true
  {{- end }}

  {{- with .Values.reaper.cassandraUserSecretRef }}
  cassandraUserSecretRef: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.reaper.containerImage }}
  containerImage: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.reaper.deploymentMode }}
  deploymentMode: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.heapSize }}
  heapSize: {{ . }}
  {{- end }}

  {{- with .Values.reaper.httpManagement }}
  httpManagement: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.reaper.keyspace }}
  keyspace: {{ . | quote }}
  {{- end }}

  {{- with .Values.reaper.livenessProbe }}
  livenessProbe: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.reaper.readinessProbe }}
  readinessProbe: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- if .Values.reaper.initContainerSecurityContext }}
  initContainerSecurityContext: {{ toYaml .Values.reaper.initContainerSecurityContext | nindent 4 }}
  {{- else }}
  initContainerSecurityContext:
    allowPrivilegeEscalation: false
    readOnlyRootFilesystem: true
    privileged: false
    capabilities:
      drop:
      - ALL
      - CAP_NET_RAW
  {{- end }}

  {{- if .Values.reaper.podSecurityContext }}
  podSecurityContext: {{ toYaml .Values.reaper.podSecurityContext | nindent 4 }}
  {{- else }}
  podSecurityContext:
    allowPrivilegeEscalation: false
    readOnlyRootFilesystem: true
    privileged: false
    capabilities:
      drop:
      - ALL
      - CAP_NET_RAW
  {{- end }}

  {{- if .Values.reaper.securityContext }}
  securityContext: {{ toYaml .Values.reaper.securityContext | nindent 4 }}
  {{- else }}
  securityContext:
    allowPrivilegeEscalation: false
    readOnlyRootFilesystem: true
    privileged: false
    capabilities:
      drop:
      - ALL
      - CAP_NET_RAW
  {{- end }}

  {{- with .Values.reaper.resources }}
  resources: {{ toYaml . | nindent 4 }}
  {{- end }}

  {{- with .Values.reaper.secretsProvider }}
  secretsProvider: {{ . | quote }}
  {{- end }}
  
  {{- if .Values.reaper.telemetry }}
  telemetry: {{ toYaml .Values.reaper.telemetry | nindent 4 }}
  {{- else if .Values.prometheus.enabled }}
  telemetry:
    prometheus:
      enabled: true
    mcac:
      enabled: false
  {{- end }}

  {{- with .Values.reaper.tolerations }}
  tolerations: {{ toYaml . | nindent 4 }}
  {{- end }}

{{- end }}
