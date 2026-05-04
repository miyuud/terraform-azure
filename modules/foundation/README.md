# foundation

Base Terraform backend resources.

## Scope
- resource group
- storage account
- storage container

## Notes
These resources are usually created manually first, then imported.
Misconfiguration here can break Terraform state operations.

## Import Example
```bash
az group list

SUBSCRIPTION_ID=
RESOURCE_GROUP_NAME=base
terragrunt import azurerm_resource_group.main /subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}

az storage account list

STORAGE_ACCOUNT=
terragrunt import azurerm_storage_account.main /subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT}

az storage container list --account-name ${STORAGE_ACCOUNT}

CONTAINER_NAME=base
terragrunt import azurerm_storage_container.main "https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER_NAME}"
```
