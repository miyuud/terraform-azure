# AKS (Legacy)

Deprecated legacy stack under `chechia/base/*`.
Keep existing stack, but prefer new layered paths for new work.

Reference:
- Azure doc: Create AKS with Terraform

Access example:
```bash
KUBECONFIG_OUTPUT_PATH="/Users/che-chia/.kube/azure-aks"
kubectl --kubeconfig ${KUBECONFIG_OUTPUT_PATH} get no
```
