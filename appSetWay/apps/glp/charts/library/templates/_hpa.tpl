{{- define "library.hpa.tpl" -}}
{{- if .Values.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "library.fullname" . }}
  labels:
    app: {{ .Values.app }}
    deployment_commit: {{ .Values.deployment_commit }}
    deployment_ref: {{ .Values.deployment_ref }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "library.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  behavior:
    scaleUp:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleUp.stabilizationWindowSeconds | default 60 }}
      selectPolicy: {{ .Values.autoscaling.scaleUp.selectPolicy | default Max }}
      policies:
        - type: Pods
          value: {{ .Values.autoscaling.scaleUp.pods | default 2  }}
          periodSeconds: {{ .Values.autoscaling.scaleUp.periodSeconds | default 60  }}
    scaleDown:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleDown.stabilizationWindowSeconds | default 300 }}
      selectPolicy: {{ .Values.autoscaling.scaleDown.selectPolicy | default Max }}
      policies:
        - type: Pods
          value: {{ .Values.autoscaling.scaleDown.pods | default 1 }}
          periodSeconds: {{ .Values.autoscaling.scaleDown.periodSeconds | default 180 }}
  metrics:
    - type: ContainerResource
      container: {{ .Values.autoscaling.container }}
      resource:
        name: cpu
        target:
          type: AverageValue
          averageValue: {{ .Values.autoscaling.targetCPUAverageValue }}
{{- end }}

{{- define "library.hpa" -}}
{{- include "library.util.merge" (append . "library.hpa.tpl") -}}
{{- end -}}