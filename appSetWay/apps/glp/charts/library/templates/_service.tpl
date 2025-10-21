{{- define "library.service" }}
{{- if ((.Values.service).enabled) }}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "library.fullname" . | trim }}
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  type: {{ .Values.service.type | default "ClusterIP" }}
  sessionAffinity: {{ .Values.service.sessionAffinity | default "None" }}
  {{- if .Values.service.clusterIP }}
  clusterIP: {{ .Values.service.clusterIP }}
  {{- end }}
  {{- if .Values.service.externalTrafficPolicy }}
  externalTrafficPolicy: {{ .Values.service.externalTrafficPolicy }}
  {{- end }}
  ports:
    {{- range .Values.service.ports }}
    - name: {{ .name }}
      port: {{ .port }}
      targetPort: {{ .targetPort | default .port }}
      protocol: {{ .protocol | default "TCP" }}
    {{- end }}
  {{- if .Values.service.selectorLabels }}
  selector: 
    {{- toYaml .Values.service.selectorLabels | nindent 4 | trim }}
  {{- else }}
  selector:
    {{ include "library.selectorLabels" . | nindent 4 }}
    {{- end }}
{{- end }}
{{- end }}
