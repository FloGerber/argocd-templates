{{- if and .Values.reaper.enabled .Values.reaper.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "k8ssandra-universal.fullname" . }}-reaper
  namespace: {{ .Values.namespace }}
  annotations:
{{ toYaml .Values.reaper.ingress.annotations | indent 4 }}
spec:
  rules:
    - host: {{ .Values.reaper.ingress.host }}
      http:
        paths:
          - path: {{ .Values.reaper.ingress.path }}
            pathType: {{ .Values.reaper.ingress.pathType }}
            backend:
              service:
                name: {{ include "k8ssandra-universal.fullname" . }}-reaper
                port:
                  number: {{ .Values.reaper.service.port }}
  {{- if .Values.reaper.ingress.tls.enabled }}
  tls:
    - hosts:
        - {{ .Values.reaper.ingress.host }}
      secretName: {{ .Values.reaper.ingress.tls.secretName }}
  {{- end }}
{{- end }}
