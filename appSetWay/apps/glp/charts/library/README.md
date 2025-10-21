# Helm Library Chart Documentation

This library chart provides reusable Helm templates to define Kubernetes resources.

## Available Template Helpers

- [library.configmap](templates/_docs/configmap.md)
- [library.container](templates/_docs/container.md)
- [library.containers](templates/_docs/containers.md)
- [library.deployment](templates/_docs/deployment.md)
- [library.fullname](templates/_docs/fullname.md)
- [library.name](templates/_docs/name.md)
- [library.labels](templates/_docs/labels.md)
- [library.selectorLabels](templates/_docs/selectorLabels.md)
- [library.hpa](templates/_docs/hpa.md)
- [library.ingress](templates/_docs/ingress.md)
- [library.initContainer](templates/_docs/initContainer.md)
- [library.initContainers](templates/_docs/initContainers.md)
- [library.networkPolicy](templates/_docs/networkPolicy.md)
- [library.probes](templates/_docs/probes.md)
- [library.secrets](templates/_docs/secrets.md)
- [library.service](templates/_docs/service.md)
- [library.volumes](templates/_docs/volumes.md)

---

### Common `.Values` Schema

| Key              | Type   | Description                             | Default                                     |
| ---------------- | ------ | --------------------------------------- | ------------------------------------------- |
| `image`          | object | Container image configuration           | `repository, tag, pullPolicy`               |
| `service`        | object | Service configuration                   | `type: ClusterIP, port: 80, targetPort: 80` |
| `resources`      | object | Resource requests and limits            | `{}`                                        |
| `livenessProbe`  | object | Liveness probe configuration            | `httpGet.path=/healthz`                     |
| `readinessProbe` | object | Readiness probe configuration           | `httpGet.path=/ready`                       |
| `serviceAccount` | object | Service account configuration           | `create: true`                              |
| `hpa`            | object | Horizontal Pod Autoscaler configuration | `enabled: false`                            |
| `networkPolicy`  | object | Network policy configuration            | `enabled: false`                            |
| `volumes`        | array  | List of volume definitions              | `[]`                                        |
| `initContainers` | array  | List of init container specs            | `[]`                                        |
| `configmap`      | object | ConfigMap configuration                 | `enabled: false`                            |
| `secrets`        | object | Secret configuration                    | `enabled: false`                            |
| `affinity`       | object | Node/pod affinity rules                 | `{}`                                        |
| `tolerations`    | array  | Pod tolerations                         | `[]`                                        |
| `nodeSelector`   | object | Node selector labels                    | `{}`                                        |

Each helper template can be included in service charts using `{{ include "library.<name>" . }}`.
