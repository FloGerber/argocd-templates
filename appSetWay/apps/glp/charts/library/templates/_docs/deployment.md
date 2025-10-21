    # `library.deployment`

    ## Purpose
    The `library.deployment` template defines the **Deployment** structure for Kubernetes objects.
    It is intended to be reused by service charts that include this library.

    ## Usage Example
    ```gotemplate
    { '{ include "library.deployment" . }' }
    ```

    ## Expected `.Values` Fields

    | Key | Type | Description | Default |
|-----|------|-------------|----------|
| `image` | object | Container image configuration | `repository, tag, pullPolicy` |
| `service` | object | Service configuration | `type: ClusterIP, port: 80, targetPort: 80` |
| `resources` | object | Resource requests and limits | `{}` |
| `livenessProbe` | object | Liveness probe configuration | `httpGet.path=/healthz` |
| `readinessProbe` | object | Readiness probe configuration | `httpGet.path=/ready` |
| `serviceAccount` | object | Service account configuration | `create: true` |
| `hpa` | object | Horizontal Pod Autoscaler configuration | `enabled: false` |
| `networkPolicy` | object | Network policy configuration | `enabled: false` |
| `volumes` | array | List of volume definitions | `[]` |
| `initContainers` | array | List of init container specs | `[]` |
| `configmap` | object | ConfigMap configuration | `enabled: false` |
| `secrets` | object | Secret configuration | `enabled: false` |
| `affinity` | object | Node/pod affinity rules | `{}` |
| `tolerations` | array | Pod tolerations | `[]` |
| `nodeSelector` | object | Node selector labels | `{}` |

    ## Example YAML Output
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: {'{ include "library.fullname" . }'}
      labels:
        app.kubernetes.io/name: {'{ include "library.name" . }'}
    spec:
      template:
        spec:
          containers:
            - name: {'{ include "library.name" . }'}
              image: "{'{ .Values.image.repository }'}:{'{ .Values.image.tag }'}"
              ports:
                - containerPort: {'{ .Values.service.targetPort | default 8080 }'}
    ```

    ## Notes
    - All fields can be overridden in your service chart `values.yaml`.
    - Optional resources (like ConfigMaps, Secrets, HPAs) should be conditionally included.
    - See root `values.schema.json` for strict validation of allowed fields.
