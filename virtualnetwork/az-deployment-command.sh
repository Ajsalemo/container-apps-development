az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./virtualnetwork.bicep \
  --parameters \
    environment_name="$CONTAINERAPPS_ENVIRONMENT" \
    location="$LOCATION" \
    vnetName="$VNET_NAME" \
    infraSubnetName="$INFRA_SUBNET" \
    runtimeSubnetName="$RUNTIME_SUBNET"