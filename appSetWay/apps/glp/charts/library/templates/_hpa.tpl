{{- define "library.hpa" }}
{{- if ((.Values.hpa).enabled )}}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "library.fullname" . | trim }}
  labels: {{ include "library.labels" . | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "library.fullname" . | trim }}
  minReplicas: {{ .Values.hpa.minReplicas | default 1 }}
  maxReplicas: {{ .Values.hpa.maxReplicas | default 3 }}
  metrics:
    {{- toYaml .Values.hpa.metrics | nindent 4 }}
  {{- if .Values.hpa.behavior }}
  behavior:
    {{- toYaml .Values.hpa.behavior | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
