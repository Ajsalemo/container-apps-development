az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./state-management.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    daprAppId="$DAPR_APP_ID" \
    storageAccountName="$STORAGE_ACCOUNT_NAME" \
    storageContainerName="$STORAGE_ACCOUNT_CONTAINER" \
    azureContainerRegistry="$AZURE_CONTAINER_REGISTRY" \
    azureContainerRegistryUsername="$AZURE_CONTAINER_REGISTRY_USERNAME" \
    azureContainerRegistryPassword="$AZURE_CONTAINER_REGISTRY_PASSWORD"
