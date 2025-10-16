{{- define "library.initContainer" -}}
- name: {{ required "initContainer.name is required" .name }}
  image: {{ required "initContainer.image.repository is required" .image.repository }}:{{ required "initContainer.image.tag is required" .image.tag }}
  imagePullPolicy: {{ .image.pullPolicy | default .Values.global.imagePullPolicy | default "Always" }}
  {{- with .command }}
  command: {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- with .args }}
  args: {{ toYaml . | nindent 2 }}
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
  {{- with .securityContext }}
  securityContext: {{ toYaml . | nindent 4 }}
  {{- else }}
  securityContext:
    allowPrivilegeEscalation: false
  {{- end }}
{{- end }}

{{- define "library.initContainers" -}}
{{- if .Values.initContainers }}
{{- range .Values.initContainers }}
{{ include "library.initContainer" . | nindent 0 }}
{{- end }}
{{- else }}
# no initContainers defined
{{- end }}
{{- end }}
