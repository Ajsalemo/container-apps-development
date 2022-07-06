az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./state-management-http.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    storageAccountName="$STORAGE_ACCOUNT_NAME" \
    storageContainerName="$STORAGE_ACCOUNT_CONTAINER" \
    azureContainerRegistry="$AZURE_CONTAINER_REGISTRY" \
    azureContainerRegistryUsername="$AZURE_CONTAINER_REGISTRY_USERNAME" \
    azureContainerRegistryPassword="$AZURE_CONTAINER_REGISTRY_PASSWORD" 

#########################################################
# Optional - State Store creation is already within the bicep file #
# AZ CLI command to create the State Store compoment
#########################################################
az containerapp env dapr-component set \
    --name $CONTAINERAPPS_ENVIRONMENT --resource-group $RESOURCE_GROUP \
    --dapr-component-name statestore \
    --yaml "../azure-components/statestore.yaml"