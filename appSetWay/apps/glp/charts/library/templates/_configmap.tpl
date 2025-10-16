{{/* Render ConfigMap if enabled */}}
{{- define "library.configmap" -}}
{{- if (.Values.configmap.enabled | default false) }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library.fullname" . | trim }}-config
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.configmap.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
data:
  {{- range $key, $value := .Values.configmap.data }}
  {{ $key }}: {{ $value | quote }}
  {{- else }}
  # no data entries defined
  {{- end }}
{{- with .Values.configmap.binaryData }}
binaryData:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}
