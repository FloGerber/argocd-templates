{{/* Generate full name for resources */}}
{{- define "library.fullname" -}}
{{- if .Values.fullnameOverride }}
{{ .Values.fullnameOverride }}
{{- else if .Values.nameOverride }}
{{ .Release.Name }}-{{ .Values.nameOverride }}
{{- else }}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
{{- end }}

{{/* Generate chart name */}}
{{- define "library.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/* Common labels */}}
{{- define "library.labels" -}}
app.kubernetes.io/name: {{ include "library.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{/* Selector labels */}}
{{- define "library.selectorLabels" -}}
app.kubernetes.io/name: {{ include "library.name" . | trim }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
