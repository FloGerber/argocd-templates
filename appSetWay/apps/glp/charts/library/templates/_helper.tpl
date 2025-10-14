{{/* Generate full name for resources */}}
{{- define "library.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate chart name */}}
{{- define "library.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/* Common labels */}}
{{- define "library.labels" -}}
app: {{ .Values.app }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
deployment_commit: {{ .Values.deployment_commit }}
deployment_ref: {{ .Values.deployment_ref }}
{{- end -}}

{{/* Selector labels */}}
{{- define "library.selectorLabels" -}}
app: {{ .Values.app }}
{{- end -}}
