{{/* Generate full name for resources */}}
{{- define "libary.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate chart name */}}
{{- define "libary.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/* Common labels */}}
{{- define "libary.labels" -}}
app: {{ .Values.app }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
deployment_commit: {{ .Values.deployment_commit }}
deployment_ref: {{ .Values.deployment_ref }}
{{- end -}}

{{/* Selector labels */}}
{{- define "libary.selectorLabels" -}}
app: {{ .Values.app }}
{{- end -}}
