
The main differnce between the Deployment and DeploymentConfig : 

DC --> It has more feature like image pull starategy and Config change issue. Image revision history.


In OpenShift, a deployment is an object that represents a specific instance of an application being deployed to the cluster. It is typically created based on a deployment configuration, which is a YAML or JSON file that defines the desired state of the deployment. The deployment configuration serves as a template for creating deployments, and it can be used to deploy multiple instances of an application with different settings or configurations.

On the other hand, a deploymentconfig is a type of deployment configuration in OpenShift that follows a specific format and includes additional features such as deployment triggers and lifecycle hooks. A deploymentconfig can be used to define the desired state of a deployment in more detail, and it provides greater control over the deployment process.

In summary, a deployment is a specific instance of an application being deployed to the cluster, while a deploymentconfig is a template for creating deployments that includes additional features for controlling the deployment process.
