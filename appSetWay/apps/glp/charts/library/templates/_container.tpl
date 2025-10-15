{{- define "library.containers" }}
{{- range .Values.containers }}
- name: {{ .name }}
  image: {{ .image }}
  imagePullPolicy: {{ .imagePullPolicy | default .Values.global.imagePullPolicy | default "Always" }}
  {{- if .command }}
  command: {{ toYaml .command | nindent 2 }}
  {{- end }}
  {{- if .args }}
  args: {{ toYaml .args | nindent 2 }}
  {{- end }}
  {{- if .ports }}
  ports:
    {{- toYaml .ports | nindent 4 }}
  {{- end }}
  {{- if .env }}
  env:
    {{- toYaml .env | nindent 4 }}
  {{- end }}
  {{- if .envFrom }}
  envFrom:
    {{- toYaml .envFrom | nindent 4 }}
  {{- end }}
  {{- if .resources }}
  resources:
    {{- toYaml .resources | nindent 4 }}
  {{- end }}
  {{- if .volumeMounts }}
  volumeMounts:
    {{- toYaml .volumeMounts | nindent 4 }}
  {{- end }}
  {{- if .lifecycle }}
  lifecycle:
    {{- toYaml .lifecycle | nindent 4 }}
  {{- end }}
  {{- include "library.probes" . | indent 2 }}
  securityContext:
    allowPrivilegeEscalation: {{ .securityContext.allowPrivilegeEscalation | default false }}
{{- end }}
{{- end }}
