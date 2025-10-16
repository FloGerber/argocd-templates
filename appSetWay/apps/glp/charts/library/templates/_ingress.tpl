{{- define "library.ingress" -}}
{{- $ingress := .Values.ingress | default dict }}
{{- if ($ingress.enabled | default false) }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "library.fullname" . | trim }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
  {{- with $ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if $ingress.className }}
  ingressClassName: {{ $ingress.className }}
  {{- end }}
  {{- if $ingress.tls }}
  tls:
    {{- toYaml $ingress.tls | nindent 4 }}
  {{- end }}
  rules:
    {{- range $ingress.hosts }}
    - host: {{ .host }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType | default "Prefix" }}
            backend:
              service:
                name: {{ .serviceName | default (include "library.fullname" $) }}
                port:
                  number: {{ .servicePort }}
          {{- end }}
    {{- end }}
{{- end }}
{{- end }}
