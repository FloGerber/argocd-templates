{{- define "library.probes" }}
{{- if .probes }}
  {{- if .probes.liveness }}
  livenessProbe:
    {{- toYaml .probes.liveness | nindent 4 }}
  {{- end }}
  {{- if .probes.readiness }}
  readinessProbe:
    {{- toYaml .probes.readiness | nindent 4 }}
  {{- end }}
  {{- if .probes.startup }}
  startupProbe:
    {{- toYaml .probes.startup | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
