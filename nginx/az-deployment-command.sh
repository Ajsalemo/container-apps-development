az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./nginx.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" 