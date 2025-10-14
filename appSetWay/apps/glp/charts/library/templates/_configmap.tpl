{{- define "library.configmap.tpl" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library.fullname" . }}
  namespace: {{ .Release.Namespace}}
data: {}

binaryData:
{{- range $key, $value := .Values.binaryData }}
    {{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{- define "library.configmap" -}}
{{- include "library.util.merge" (append . "library.configmap.tpl") -}}
{{- end -}}