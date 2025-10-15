{{- define "library.initContainers" }}
{{- if .Values.initContainers }}
{{- range .Values.initContainers }}
- name: {{ .name }}
  image: {{ .image }}
  imagePullPolicy: {{ .imagePullPolicy | default .Values.global.imagePullPolicy | default "Always" }}
  {{- if .command }}
  command: {{ toYaml .command | nindent 2 }}
  {{- end }}
  {{- if .args }}
  args: {{ toYaml .args | nindent 2 }}
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
  {{- if .securityContext }}
  securityContext:
    {{- toYaml .securityContext | nindent 4 }}
  {{- else }}
  securityContext:
    allowPrivilegeEscalation: false
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
