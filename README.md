# container-apps-development

Examples that have been deployed to [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) in different languages utilizing HTTP or gRPC with [Dapr](https://dapr.io/). 

Deployed to Container Apps with [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli). These can also be ran locally under the `kubernetes` folder to a local Kubernetes cluster.

**Main project structure**:
- `bicep`: These folders contain a deployment Bicep or ARM template. Use the `env.sh` or `variables.sh` file to populate environment variables for deployment. Eg., `source env.sh` in a terminal **first**.

    Then, to deploy any of the sub projects, copy the `az-deployment-command.sh` contents into your terminal and run the command to execute deployment. 

- `kubernetes`: Use this folder to deploy any of the subprojects to run this on a local Kubernetes cluster. Some projects container this.

- `azure-components`: This folder can be used if optionally wanting to deploy the Dapr component through the AZ CLI instead of through Bicep.

```
|-- `dockerhub`
|    |-- `bicep` 
|-- `nginx`
|   |-- `bicep`
|-- `node`
|   |-- `service-invocation-http`
|   |-- `state-management-http-azureblob`
|   |-- `state-management-http-redis`
|   |-- `storage-volumes
|-- `php`
|   |-- `service-invocation-http`
|   |-- `state-management-http`
|-- `python`
|   |-- `grpc`
|   |-- `grpc-reflection`
|   |-- `managed-identity`
|   |-- `pub-sub`
|   |-- `service-invocation-grpc`
|   |-- `service-invocation-http`
|   |-- `state-management-http`
|-- `virtualnetwork`
|   |-- 
```


