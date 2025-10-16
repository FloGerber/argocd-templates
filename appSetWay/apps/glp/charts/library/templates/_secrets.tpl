{{- define "library.secrets" }}
{{- if .Values.secrets.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library.fullname" . | trim }}-secret
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.secrets.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
type: {{ .Values.secrets.type | default "Opaque" }}
{{- if .Values.secrets.stringData }}
stringData:
  {{- range $key, $value := .Values.secrets.stringData }}
  {{ $key }}: {{ $value | quote }}
  {{- end }}
{{- end }}
{{- if .Values.secrets.data }}
data:
  {{- toYaml .Values.secrets.data | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}
