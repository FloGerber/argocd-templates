{{- define "library.volumes" }}
{{- if .Values.volumes }}
{{- range .Values.volumes }}
- name: {{ .name }}
  {{- if .configMap }}
  configMap:
    {{- toYaml .configMap | nindent 4 }}
  {{- end }}
  {{- if .secret }}
  secret:
    {{- toYaml .secret | nindent 4 }}
  {{- end }}
  {{- if .emptyDir }}
  emptyDir:
    {{- toYaml .emptyDir | nindent 4 }}
  {{- end }}
  {{- if .persistentVolumeClaim }}
  persistentVolumeClaim:
    {{- toYaml .persistentVolumeClaim | nindent 4 }}
  {{- end }}
  {{- if .projected }}
  projected:
    {{- toYaml .projected | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
