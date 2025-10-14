{{- define "library.secret.tpl" -}}
{{- if .Values.secret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library.fullname" . }}-secret
  labels:
    app: {{ .Values.app }}
    deployment_commit: {{ .Values.deployment_commit }}
    deployment_ref: {{ .Values.deployment_ref }}
type: Opaque
data:
{{- range $key, $value := .Values.secret.data }}
  {{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "library.secret" -}}
{{- include "library.util.merge" (append . "library.secret.tpl") -}}
{{- end -}}
