{{- define "k8ssandra.resources" -}}
resources:
{{- with .requests }}
  requests:
{{ toYaml . | indent 4 }}
{{- end }}
{{- with .limits }}
  limits:
{{ toYaml . | indent 4 }}
{{- end }}
{{- end }}
