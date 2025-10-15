{{- define "library.networkPolicy" }}
{{- if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ include "library.fullname" . }}-network-policy
  labels: {{ include "library.labels" . | nindent 4 }}
spec:
  podSelector:
    matchLabels: {{ include "library.selectorLabels" . | nindent 4 }}
  policyTypes:
    {{- range .Values.networkPolicy.policyTypes }}
    - {{ . }}
    {{- end }}
  {{- if .Values.networkPolicy.ingress }}
  ingress:
    {{- toYaml .Values.networkPolicy.ingress | nindent 4 }}
  {{- end }}
  {{- if .Values.networkPolicy.egress }}
  egress:
    {{- toYaml .Values.networkPolicy.egress | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
