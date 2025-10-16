{{/* 
Render a single container spec.
Expects:
- .name (string)
- .image.repository (string)
- .image.tag (string)
- .image.pullPolicy (string, optional)
*/}}
{{- define "library.container" -}}
- name: {{ required "container.name is required" .name }}
  image: {{ required "container.image.repository is required" .image.repository }}:{{ required "container.image.tag is required" .image.tag }}
  imagePullPolicy: {{ .image.pullPolicy | default .Values.global.imagePullPolicy | default "Always" }}
  {{- with .command }}
  command: {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- with .args }}
  args: {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- with .ports }}
  ports: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .env }}
  env: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .envFrom }}
  envFrom: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .resources }}
  resources: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .volumeMounts }}
  volumeMounts: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .lifecycle }}
  lifecycle: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- include "library.probes" . | indent 2 }}
  securityContext:
    allowPrivilegeEscalation: {{ .securityContext.allowPrivilegeEscalation | default false }}
{{- end }}

{{/* Render all containers */}}
{{- define "library.containers" -}}
{{- if .Values.containers }}
{{- range .Values.containers }}
{{ include "library.container" . | nindent 0 }}
{{- end }}
{{- else }}
# no containers defined
{{- end }}
{{- end }}
