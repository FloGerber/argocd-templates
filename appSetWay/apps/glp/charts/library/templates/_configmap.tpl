{{- define "library.configmap" }}
{{- if .Values.configmap.enabled }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library.fullname" . }}-config
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.configmap.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
data:
  {{- range $key, $value := .Values.configmap.data }}
  {{ $key }}: {{ $value | quote }}
  {{- end }}
{{- if .Values.configmap.binaryData }}
binaryData:
  {{- toYaml .Values.configmap.binaryData | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}
