{{- define "library.deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "library.fullname" . }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "library.selectorLabels" . | nindent 6 }}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 25%
  template:
    metadata:
      labels:
        {{- include "library.selectorLabels" . | nindent 8 }}
      annotations:
        {{- toYaml .Values.podAnnotations | nindent 8 }}
    spec:
      automountServiceAccountToken: false
      containers:
        - name: {{ .Values.app }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: Always
          ports:
            {{- range .Values.containerPorts }}
            - containerPort: {{ .port }}
              name: {{ .name }}
              protocol: {{ .protocol | default "TCP" }}
            {{- end }}
          env:
            {{- range .Values.env }}
            - name: {{ .name }}
              value: {{ .value | quote }}
            {{- end }}
          envFrom:
            {{- range .Values.envFrom }}
            - secretRef:
                name: {{ .secretRef.name }}
            {{- end }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          lifecycle:
            {{- toYaml .Values.lifecycle | nindent 12 }}
          livenessProbe:
            {{- toYaml .Values.livenessProbe | nindent 12 }}
          readinessProbe:
            {{- toYaml .Values.readinessProbe | nindent 12 }}
          startupProbe:
            {{- toYaml .Values.startupProbe | nindent 12 }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          volumeMounts:
            {{- toYaml .Values.volumeMounts | nindent 12 }}
      initContainers:
        {{- toYaml .Values.initContainers | nindent 8 }}
      hostAliases:
        {{- toYaml .Values.hostAliases | nindent 8 }}
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
      affinity:
        {{- toYaml .Values.affinity | nindent 8 }}
      restartPolicy: Always
      terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds | default 60 }}
{{- end -}}

{{- define "library.deployment" -}}
{{- include "library.util.merge" (append . "library.deployment.tpl") -}}
{{- end -}}
