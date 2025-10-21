{{/* Render ConfigMap if enabled */}}
{{- define "library.configmap" -}}
{{- if ((.Values.configmap).enabled) }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library.fullname" . | trim }}-config
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.configmap.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- if .Values.configmap.data }}
data:
  {{- range $key, $value := .Values.configmap.data }}
  {{ $key }}: {{ $value | quote }}
  {{- end}}
  # no data entries defined
{{- end }}
{{- with .Values.configmap.binaryData }}
binaryData:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}
