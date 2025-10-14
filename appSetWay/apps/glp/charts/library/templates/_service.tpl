{{- define "library.service.tpl" -}}

apiVersion: v1
kind: Service
metadata:
  name: {{ include "library.fullname" . }}
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.service.annotations }}
  annotations:
{{ toYaml . | indent 4 }}
  {{- end }}
spec:
  type: {{ .Values.service.type | default "ClusterIP" }}
  sessionAffinity: {{ .Values.service.sessionAffinity | default "None" }}
  selector:
    app: {{ .Values.app }}

  internalTrafficPolicy: {{ .Values.service.internalTrafficPolicy | default "Cluster" }}
  ipFamilies:
    - {{ .Values.service.ipFamily | default "IPv4" }}
  ipFamilyPolicy: {{ .Values.service.ipFamilyPolicy | default "SingleStack" }}
  ports:
{{- range .Values.service.ports }}
    - name: {{ .name }}
      port: {{ .port }}
      protocol: {{ .protocol }}
      targetPort: {{ .targetPort }}
{{- end }}


{{- define "library.service" -}}
{{- include "library.util.merge" (append . "library.service.tpl") -}}
{{- end -}}