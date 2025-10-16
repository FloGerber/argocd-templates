{{/*
Render a Deployment resource if enabled.
This template delegates most of the heavy lifting to smaller helpers:
- library.fullname / library.labels / library.selectorLabels
- library.volumes
- library.initContainers
- library.containers
*/}}
{{- define "library.deployment" -}}
{{- if .Values.deployment.enabled }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "library.fullname" . | trim }}
  labels: {{ include "library.labels" . | nindent 4 }}
  {{- with .Values.deployment.annotations }}
  annotations: {{ toYaml . | nindent 4 }}
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
      {{- with .Values.podAnnotations }}
      annotations: {{ toYaml . | nindent 8 }}
      {{- end }}
    spec:
      {{- with .Values.serviceAccount }}
      serviceAccountName: {{ .name | default "default" }}
      automountServiceAccountToken: {{ .automount | default false }}
      {{- else }}
      serviceAccountName: default
      automountServiceAccountToken: false
      {{- end }}
      terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds | default 60 }}

      {{- with .Values.affinity }}
      affinity: {{ toYaml . | nindent 8 }}
      {{- end }}

      {{- with .Values.hostAliases }}
      hostAliases: {{ toYaml . | nindent 8 }}
      {{- end }}

      {{- if .Values.volumes }}
      volumes:
        {{- include "library.volumes" . | nindent 8 }}
      {{- end }}

      {{- if .Values.initContainers }}
      initContainers:
        {{- include "library.initContainers" . | nindent 8 }}
      {{- end }}

      {{- if .Values.containers }}
      containers:
        {{- include "library.containers" . | nindent 8 }}
      {{- else }}
      # no containers defined
      {{- end }}
{{- end }}
{{- end }}
