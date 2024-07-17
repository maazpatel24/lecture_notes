## Basic file structure for kubernets

### apiVersion

+ apiVersion is a string that identifies the version of the Kubernetes API. It is used to determine the schema of the object.

> Example:

```yml
apiVersion: apps/v1
```
+ In this example, the apiVersion is apps/v1, which indicates that the object is a Deployment in the apps API group, version v1.

### kind

+ kind is a string that identifies the type of object. It is used to determine the type of object being created or updated.

> Example:
```yml
kind: Deployment
```
+ In this example, the kind is Deployment, which indicates that the object is a Deployment.

### metadata

+ metadata is an object that contains metadata about the object. It typically includes information such as the object's name, namespace, and labels.

> Example:

```yml
metadata:
  name: nginx-deployment
  namespace: default
  labels:
    app: nginx
```

+ In this example, the metadata object contains the name, namespace, and labels of the Deployment.

### spec

+ spec is an object that contains the desired state of the object. It is used to define the configuration of the object.

> Example:

```yml
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16.1
        ports:
        - containerPort: 80
```
+ In this example, the spec object defines the desired state of the Deployment, including the number of replicas, the selector, and the template for the Pods.

+ apiVersion, kind, metadata, and spec are all important components of a Kubernetes YAML file.

+ apiVersion specifies the version of the Kubernetes API that the object is using. This is important because different versions of the API may have different schemas and features.

+ kind specifies the type of object that the YAML file is defining. For example, it could be a Deployment, a Service, a Pod, or any other type of Kubernetes object.

+ metadata contains data that helps identify the object, such as its name, namespace, labels, and annotations.

+ spec defines the desired state of the object. It includes information such as the number of replicas, the container images, the ports that should be open, and any other configuration settings that are specific to the type of object being defined.

+ Together, these components allow you to define and create complex Kubernetes objects that can be used to deploy and manage applications on a Kubernetes cluster.


<br>

---

<br>




```bash
my-kubernetes-project/
└── manifests/
    |
    ├── deployment.yaml
    |
    ├── service.yaml
    |
    ├── configmap.yaml
    |
    ├── secret.yaml
    |
    ├── cronjobs/
    │   └── backup-cronjob.yaml
    |
    ├── jobs/
    │   └── data-import-job.yaml
    |
    ├── persistentvolumeclaims/
    │   └── storage-claim.yaml
    |
    └── statefulsets/
        └── mysql-statefulset.yaml
```



## Explanation of Components

 1. deployment.yaml: Defines how your application should be deployed, including the number of replicas and update strategy.

 2. service.yaml: Specifies how your application should be accessed, such as through a LoadBalancer, NodePort, or ClusterIP.

 3. configmap.yaml and secret.yaml: Store configuration and sensitive data respectively, which can be mounted into Pods as volumes or exposed as environment variables.

 4. cronjobs/ and jobs/: Define periodic tasks (CronJob) or one-off tasks (Job) to be executed within the cluster.

 5. persistentvolumeclaims/: Requests storage from a PersistentVolume to persist data beyond the lifetime of a Pod.

 6. statefulsets/: Manages stateful applications, ensuring predictable deployment and scaling behaviors for stateful applications like databases.

 7. Benefits of Organized File Structure Clarity and Organization: Helps in easily locating and managing different resources and components of your application.

 8. Version Control: Facilitates tracking changes and managing versions using version control systems like Git.
  
 9. Reusability: Encourages reuse of common configuration patterns across different parts of your application.

 10. Automation: Simplifies automation of deployments, updates, and scaling using tools like Helm, kubectl apply, or CI/CD pipelines.



