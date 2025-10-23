{{- /*
Named template:
- k8ssandra.medusa : renders a cassandra block
*/ -}}
{{- define "k8ssandra.medusa" -}}
medusa:
  enabled: {{ .Values.medusa.enabled }}
  backups:
    schedule: "{{ .Values.medusa.backups.schedule }}"
  storage:
    type: "{{ .Values.medusa.storage.type }}"
    s3:
      bucketName: "{{ .Values.medusa.storage.s3.bucketName }}"
      region: "{{ .Values.medusa.storage.s3.region }}"
      endpoint: "{{ .Values.medusa.storage.s3.endpoint }}"
    gcs:
      bucketName: "{{ .Values.medusa.storage.gcs.bucketName }}"
    azure:
      container: "{{ .Values.medusa.storage.azure.container }}"
    credentialsSecret: "{{ .Values.medusa.storage.credentialsSecret }}"
  resources: {{ toYaml .Values.medusa.resources | nindent 2 }}
  env: {{ toYaml .Values.medusa.env | nindent 2 }}
{{- end -}}