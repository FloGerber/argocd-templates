# k8ssandra-enterprise (fixed & CRD-aligned)

This Helm chart renders a `K8ssandraCluster` CR compliant with the latest K8ssandra Operator CRD.

## What I changed
- Fixed templates to match the current `K8ssandraClusterSpec` structure.
- Modularized cassandra / medusa / reaper templates (`_cassandra.tpl`, `_medusa.tpl`, `_reaper.tpl`).
- Updated `values.yaml` with enterprise defaults and Vault ExternalSecrets references.
- Added inline comments in templates for maintainability.
- Performed basic wiring checks to ensure templates include the defined helper blocks.

## Secrets and Vault (recommended workflow)
1. Install ExternalSecrets operator and configure a `SecretStore` for HashiCorp Vault. Example `SecretStore` is cluster-specific and not included here.
2. Store secrets in Vault (KV v2 paths used by default in `values.yaml`).
3. ExternalSecret manifests (not included) should map Vault secrets to Kubernetes Secret names expected by your operator/operator webhooks.
4. Set `secretsProvider: external` in `values.yaml`. The operator will look for the Secrets in the cluster and use them for superuser & TLS settings.

## File overview
- `templates/k8ssandracluster.yaml` — main CR; tiny and uses modular includes.
- `templates/_cassandra.tpl` — renders `.spec.cassandra` block.
- `templates/_medusa.tpl` — renders `.spec.medusa` block.
- `templates/_reaper.tpl` — renders `.spec.reaper` block.
- `values.yaml` — default values tuned for production (no secret material).
- `values.schema.json` — (NOT modified) consider adding schema to validate `values.yaml` in CI.

## Next steps / suggestions
- Add ExternalSecret manifests for your Vault paths (I can generate these for you per Vault layout).
- Add `values.schema.json` to enforce types in CI (I can add a strict schema if desired).
- Add ServiceMonitor and RBAC templates for monitoring/backups as needed.

