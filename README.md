# container-apps-development

Examples that have been deployed to [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) in different languages utilizing HTTP or gRPC with [Dapr](https://dapr.io/). These are all mostly pulled from existing Dapr samples. 

Deployed to Container Apps with [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli). These can be ran locally under the `kubernetes` folder to a local k8s cluster.

`python`
  - `service-invocation-grpc`: An app using [Dapr with gRPC](https://docs.dapr.io/developing-applications/sdks/python/python-sdk-extensions/python-grpc/)
    - `bicep`: Contains files to deploy the Container App, includes an Application Insights, Log Analytics, Container App Environment and Container App resource.
        - `env.sh`: Contains environment variables to be used in the `state-management.bicep` file
        - `az-deployment-command.sh`: AZ CLI command to use for the BICEP file
        - `state-management.bicep`: BICEP file that deploys the `state-management-http` solution
    - `grpc-client`: gRPC client application
    - `grpc-server`: gRPC server application
    - `kubernetes`: This can be used to deploy Kubernetes Services and Deployments if running locally

  <br>

  - `service-invocation-http`: An app using [Dapr with service invocation](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/service-invocation-overview/)
      - `bicep`: Contains files to deploy the Container App, includes an Application Insights, Log Analytics, Container App Environment and Container App resource.
        - `env.sh`: Contains environment variables to be used in the `state-management.bicep` file
        - `az-deployment-command.sh`: AZ CLI command to use for the BICEP file
        - `state-management.bicep`: BICEP file that deploys the `state-management-http` solution
      - `checkout`: Checkout application
      - `kubernetes`: This can be used to deploy Kubernetes Services and Deployments if running locally
      - `order-processor`: Order Processor application
  
  <br>

  - `state-management-http`: An app using [Dapr with state management](https://docs.dapr.io/developing-applications/building-blocks/state-management/)
      - `azure-components`: Components specific to Dapr on Azure. This can be used if using the [AZ CLI to deploy components separately](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr?tabs=bash#configure-the-state-store-component)
      - `bicep`: Contains files to deploy the Container App, includes an Application Insights, Log Analytics, Container App Environment and Container App resource.
        - `env.sh`: Contains environment variables to be used in the `state-management.bicep` file
        - `az-deployment-command.sh`: AZ CLI command to use for the BICEP file
        - `state-management.bicep`: BICEP file that deploys the `state-management-http` solution
      - `components`: This component `.yaml` can be used for local Kubernetes components
      - `kubernetes`: This can be used to deploy Kubernetes Services and Deployments if running locally

   <br>
   
   - `grpc`: A containerized example using the gRPC package for Python. This example doesn't use reflection
