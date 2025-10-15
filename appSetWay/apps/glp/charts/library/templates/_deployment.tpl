{{- define "library.deployment" }}
{{- if .Values.deployment.enabled }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "library.fullname" . }}
  labels: {{ include "library.labels" . | nindent 4 }}
  annotations:
    {{- with .Values.deployment.annotations }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
spec:
  replicas: {{ .Values.deployment.replicas | default 1 }}
  revisionHistoryLimit: {{ .Values.deployment.revisionHistoryLimit | default 10 }}
  strategy:
    type: {{ .Values.deployment.strategy.type | default "RollingUpdate" }}
    rollingUpdate:
      maxSurge: {{ .Values.deployment.strategy.rollingUpdate.maxSurge | default 1 }}
      maxUnavailable: {{ .Values.deployment.strategy.rollingUpdate.maxUnavailable | default "25%" }}
  selector:
    matchLabels: {{ include "library.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels: {{ include "library.selectorLabels" . | nindent 8 }}
      annotations:
        {{- with .Values.podAnnotations }}
        {{ toYaml . | nindent 8 }}
        {{- end }}
    spec:
      serviceAccountName: {{ .Values.serviceAccount.name | default "default" }}
      automountServiceAccountToken: {{ .Values.serviceAccount.automount | default false }}
      terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds | default 60 }}
      affinity:
        {{- toYaml .Values.affinity | nindent 8 }}
      hostAliases:
        {{- toYaml .Values.hostAliases | nindent 8 }}
      volumes:
        {{- include "library.volumes" . | nindent 8 }}
      initContainers:
        {{- include "library.initContainers" . | nindent 8 }}
      containers:
        {{- include "library.containers" . | nindent 8 }}
{{- end }}
{{- end }}