az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./state-management-redis.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    azureContainerRegistry="$AZURE_CONTAINER_REGISTRY" \
    azureContainerRegistryUsername="$AZURE_CONTAINER_REGISTRY_USERNAME" \
    azureContainerRegistryPassword="$AZURE_CONTAINER_REGISTRY_PASSWORD" \
    azureRedisHost="$AZURE_REDIS_HOST" \
    azureRedisPassword="$AZURE_REDIS_PASSWORD" \
    azureRedisEnableTLS=false



