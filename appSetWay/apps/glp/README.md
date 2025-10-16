# GLP Umbrella Helm Chart

## Overview

This repository implements a **Helm umbrella chart** named `glp` that deploys multiple microservices.  
Each microservice (e.g., `tracker`, `photon`, `tripbuilder`) is represented as a **subchart** under `glp/charts/`.

All subcharts utilize a shared **library chart** (`glp/charts/library/`) which defines common Kubernetes resource templates such as Deployments, Services, ConfigMaps, Ingresses, and Probes.

This architecture improves consistency, maintainability, and code reuse across all service charts.

---

## 📁 Repository Structure

```
glp/
├── Chart.yaml            # Umbrella chart definition
├── values.yaml           # Global configuration (shared across subcharts)
├── charts/
│   ├── library/          # Reusable templates for Deployments, Services, etc.
│   ├── tracker/          # Example service chart
│   ├── photon/
│   ├── tripbuilder/
│   ├── ... (other service charts)
└── README.md (you are here)
```

# Diagram: Umbrella and Library Relationships

```bash
glp (umbrella)
│
├── library (shared templates)
│     ├── _deployment.tpl
│     ├── _service.tpl
│     ├── _configmap.tpl
│     ├── _ingress.tpl
│     └── _helper.tpl
│
├── tracker
│     ├── Chart.yaml
│     ├── values.yaml
│     └── templates/base.yaml → includes library templates
│
├── photon
│     ├── Chart.yaml
│     ├── values.yaml
│     └── templates/base.yaml → includes library templates
│
└── ... (other services)
```

---

## 🧩 Library Chart Pattern

The `library` chart contains only `_*.tpl` template files and **no manifests**.  
It exposes reusable partial templates that are included by each service chart.

Example usage from a service chart’s `templates/base.yaml`:

```yaml
{{- include "library.deployment" . }}
{{- include "library.service" . }}
```

Each `_*.tpl` file in the library chart provides a specific resource type (e.g. `_deployment.tpl`, `_service.tpl`).  
These partials use values from the service’s `values.yaml` and global defaults from the umbrella chart’s `values.yaml`.

---

## 📦 Included Charts

| Service Name         | Description                                   | Sidecars | Init Containers | Autoscaling | Ingress |
| -------------------- | --------------------------------------------- | -------- | --------------- | ----------- | ------- |
| `photonbg`           | Search backend for photon-based geolocation   | ❌       | ❌              | ✅ 1→1      | ❌      |
| `positianstream`     | Real-time position ingestion and processing   | ❌       | ❌              | ✅ 1→4      | ❌      |
| `positianui`         | Web UI for position visualization             | ❌       | ❌              | ❌          | ✅      |
| `roadnetworkservice` | Routing and matching engine for road networks | ✅       | ❌              | ✅ 1→5      | ❌      |
| `tcmappingeditor`    | UI for editing toll context mappings          | ❌       | ❌              | ❌          | ✅      |
| `tcmsky`             | Toll context management interface             | ❌       | ❌              | ❌          | ✅      |
| `tcservicebg`        | Tolling engine with tower and linker sidecars | ✅       | ✅              | ✅ 1→4      | ❌      |
| `tileserver`         | Tile caching and rendering service            | ✅       | ❌              | ✅ 1→5      | ❌      |
| `tracker`            | Device tracking and Kafka ingestion           | ❌       | ❌              | ✅ 1→1      | ❌      |
| `tripbuilder`        | Trip construction and segment processing      | ❌       | ✅              | ✅ 1→4      | ❌      |

---

## ⚙️ Adding a New Service Chart

1. Copy one of the existing service charts, e.g.:
   ```bash
   cp -r glp/charts/tracker glp/charts/newservice
   ```
2. Edit `Chart.yaml`:
   ```yaml
   apiVersion: v2
   name: newservice
   version: 0.1.0
   dependencies:
     - name: library
       version: "1.x.x"
       repository: "file://../library"
   ```
3. Edit `values.yaml` to set image and service parameters:
   ```yaml
   image:
     repository: my-registry/newservice
     tag: "1.0.0"
   service:
     port: 8080
   ```
4. Ensure `templates/base.yaml` includes the library templates:
   ```yaml
   {{ include "library.deployment" . }}
   {{ include "library.service" . }}
   ```
5. Lint and test:
   ```bash
   helm lint glp/charts/newservice
   ```

---

# Documenting Values.yaml Files

Each chart under `glp/charts/` should have a `values.yaml` with clear comments.

Example:

```yaml
# Default values for tracker service

image:
  repository: myregistry/tracker
  tag: "1.0.0" # Always pin to a version, avoid 'latest'
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 8080

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 512Mi
```

---

## 🧪 Linting and Testing Charts

To validate your entire Helm umbrella setup:

```bash
helm dependency update glp
helm lint glp --with-subcharts
helm template glp | kubeval
```

---

## 🧩 Shared Features

All charts use a common Helm library for:

- 🔐 Secrets and ConfigMaps
- 📈 HorizontalPodAutoscaler
- 🔒 NetworkPolicy
- 🧪 Probes (liveness, readiness, startup)
- 🧹 Lifecycle hooks
- 🧭 Affinity rules
- 📦 Resource limits and requests

## 📚 References

- [Helm documentation](https://helm.sh/docs/)
- [Helm Library Charts guide](https://helm.sh/docs/topics/library_charts/)
- [Chart Testing tool](https://github.com/helm/chart-testing)
