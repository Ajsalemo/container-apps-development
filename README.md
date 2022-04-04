# dapr-container-apps

Examples that have been deployed to [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) in different languages utilizing HTTP or gRPC with [Dapr](https://dapr.io/). These are all mostly pulled from existing Dapr samples. 

Deployed to Container Apps with [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli). These can be ran locally under the `kubernetes` folder to a local k8s cluster.

`python`
  - `service-invocation-grpc`: An app using [Dapr with gRPC](https://docs.dapr.io/developing-applications/sdks/python/python-sdk-extensions/python-grpc/)
  - `service-invocation-http`: An app using [Dapr with service invocation](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/service-invocation-overview/)