az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./dockerhub.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    dockerContainerRepository="$DOCKER_CONTAINER_REPOSITORY" \
    dockerContainerRegistryUsername="$DOCKER_CONTAINER_REGISTRY_USERNAME" \
    dockerContainerRegistryPassword="$DOCKER_CONTAINER_REGISTRY_PASSWORD" 
