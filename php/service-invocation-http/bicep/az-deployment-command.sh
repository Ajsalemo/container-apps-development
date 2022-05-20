az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./service-invocation.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    appKey="$APP_KEY" \
    daprAppId="$DAPR_APP_ID" \
    azureContainerRegistry="$AZURE_CONTAINER_REGISTRY" \
    azureContainerRegistryUsername="$AZURE_CONTAINER_REGISTRY_USERNAME" \
    azureContainerRegistryPassword="$AZURE_CONTAINER_REGISTRY_PASSWORD"