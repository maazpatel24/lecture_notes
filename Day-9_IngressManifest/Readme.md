# Project Overview

- Participants are required to deploy a simple static web application on a Kubernetes cluster using Minikube, set up advanced ingress networking with URL rewriting and sticky sessions, and configure horizontal pod autoscaling to manage traffic efficiently. 

-  The project will be divided into stages, with each stage focusing on specific aspects of Kubernetes ingress, URL rewriting, sticky sessions, and autoscaling.


## Requirements and Deliverables

### Stage 1: Setting Up the Kubernetes Cluster and Static Web App

#### 1. Set Up Minikube:

- Ensure Minikube is installed and running on the local Ubuntu machine.

#### Step1: Install the latest minikube stable release on x86-64 Linux using Debian package:

``` bash
sudo apt-get update  
sudo apt-get install -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```
#### Step2: Start minikube

```bash
minikube start
```

#### Step3: Check minikube status.

```bash
minikube status
```
---
#### 2. Deploy Static Web App:

- Create a Dockerfile for a simple static web application (e.g., an HTML page served by Nginx).

- Before making docker we will create one basic "index.html" file

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CustomPage</title>
</head>
<body>
    <center><h1>Hello from Maaz Patel!</h1></center> 
    <center><p>This is a simple static front-end served by Nginx.</p></center>
</body>
</html>
```

- Creating a Dockerfile

```Dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/

EXPOSE 80
```

- Build a Docker image for the static web application.

```bash
docker build -t maazpatel24/nginx-k8s-ingress:latest .
```

- Push the Docker image to Docker Hub or a local registry.

```bash
docker push maazpatel24/nginx-k8s-ingress:latest
```

---
#### 3. Kubernetes Deployment:

+ Write a Kubernetes deployment manifest to deploy the static web application.

- creating a deployment.yml file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-webapp-deploy
  labels:
    name: nginx-webapp-deploy
    app: maaz-custom-page
spec:
  replicas: 2
  selector:
    matchLabels:
      name: nginx-for-ingress-pod
      app: maaz-custom-page
  template:
    metadata:
      labels:
        name: nginx-for-ingress-pod
        app: maaz-custom-page
    spec:
      containers:
      - name: nginx-for-ingress
        image: maazpatel24/nginx-k8s-ingress:latest
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: 50m
          requests:
            cpu: 20m
```

- Write a Kubernetes service manifest to expose the static web application within the cluster.

- Creating a "service.yml" file

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-webapp-service
  labels:
    name: nginx-webapp-service
    app: maaz-custom-page
spec:
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  selector:
    name: nginx-for-ingress-pod
    app: maaz-custom-page 
```


- Apply the deployment and service manifests to the Kubernetes cluster.

```bash
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

#### Deliverables:

- Dockerfile for the static web app
- Docker image URL
- Kubernetes deployment and service YAML files

---
### Stage 2: Configuring Ingress Networking

#### 4. Install and Configure Ingress Controller:



- [Install an ingress controller (e.g., Nginx Ingress Controller) in the Minikube cluster.](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/)

- To install the Nginx Ingress Controller, you can use

```bash
minikube addons enable ingress
```

- Verify the ingress controller is running and accessible.

- To verify that the ingress controller is running and accessible, you can use the following command:

```bash
kubectl get pods -n ingress-nginx
```

---

#### 5. Create Ingress Resource:

- Write an ingress resource manifest to route external traffic to the static web application.


- now we will create a ingress-resource.yml file

```yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /maazpatel
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
  - host: myapp.maaz
    http:
      paths:
      - path: /diffpath
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
  - host: myapp.local
    http:
      paths:
      - path: /maazpatel24
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
```

- Configure advanced ingress rules for path-based routing and host-based routing (use at least two different hostnames and paths).

```bash
sudo nano /etc/hosts
```

- after redirecting to this path write your custom website name with minikube ip

```bash
192.168.49.2  myapp.local myapp.maaz
```

- once it create successfully just visit your given name url www.myweb.local to check your output


#### Implement TLS termination for secure connections.

To implement TLS certificate we will create one certificate file 

To create a TLS certification perform the following command:


1. Generate RSA Private Key: 

```bash
openssl genpkey -algorithm RSA -out tls.key -pkeyopt rsa_keygen_bits:2048
```

2. Generate Certificate Signing Request (CSR):

```bash
openssl req -new -key tls.key -out tls.csr
```

3. Generate Self-Signed Certificate:

```bash
openssl x509 -req -in tls.csr -signkey tls.key -out tls.crt -days 365
```

4. Create Kubernetes Secret

```bash
kubectl create secret tls app-secrets --cert=tls.crt --key=tls.key 
```

+ this will allow you to attached the self-signed certificate with generated private key and certification  

+ Configure URL rewriting in the ingress resource to modify incoming URLs before they reach the backend services.

```yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /maaz
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/affinity: "cookie"
    nginx.ingress.kubernetes.io/session-cookie-name: "route"
spec:
  tls:
    - secretName: myapp-local-tls-secret
      hosts:
        - myapp.local
        - myapp.maaz
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /maazpatel
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
  - host: myapp.maaz
    http:
      paths:
      - path: /diffpath
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
  - host: myapp.local
    http:
      paths:
      - path: /maazpatel24
        backend:
          service:
            name: nginx-webapp-service
            port:
              number: 80
        pathType: Prefix
```

+ It will define TLS certification for two different hosts as well we can see two different hosts live on the server



---


#### Deliverables:


+ Ingress controller installation commands/scripts

+ Ingress resource YAML file with advanced routing, TLS configuration, URL rewriting, and sticky sessions


---

### Stage 3: Implementing Horizontal Pod Autoscaling

#### 6. Configure Horizontal Pod Autoscaler:

+ Write a horizontal pod autoscaler (HPA) manifest to automatically scale the static web application pods based on CPU utilization.

+ let first create the "hpa.yml" file

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: nginx-webapp-hpa2
  labels:
    name: nginx-webapp-deploy
    app: maaz-custom-page
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-webapp-deploy
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Percent
        averageUtilization: 50
```



#### 7. Stress Testing:

+ Perform stress testing to simulate traffic and validate the HPA configuration.


+ To generate traffic we will use one command which is known as "apache-benches" to generate load on the website

```bash
ab -n 100000 -c 100 https://myweb.local/live
```

+ The command ab -n 100000 -c 100 http://website.com is used to simulate a load test on the specified website (http://website.com). 

+ Here’s a breakdown of the options:

  + -n 1000: specifies the total number of requests to be sent (1000 in this case).

  + -c 100: sets the concurrency level, which means 100 simultaneous requests will be made.

  + http://website.com: the URL being tested

+ Monitor the scaling behavior and ensure the application scales up and down based on the load.

```bash
kubectl get hpa
```



#### Deliverables:

+ Horizontal pod autoscaler YAML file

+ Documentation or screenshots of the stress testing process and scaling behavior


---

### Stage 4: Final Validation and Cleanup

#### 8. Final Validation:
+ Validate the ingress networking, URL rewriting, and configurations by accessing the web application through different hostnames and paths.

+ Verify the application's availability and performance during different load conditions.


#### 9. Cleanup:

+ Provide commands or scripts to clean up the Kubernetes resources created during the project (deployments, services, ingress, HPA).

+ to clean-up the deployment

```bash
kubectl delete deployment <deployment-name>
```

+ to clean-up the services

```bash
kubectl delete svc <services-name>
```

+ to clean-up the hpa

```
kubectl delete hpa --all
```

+ note : -- all will going to delete all the horizontalpodautoscalers 


+ At the end stop the minikube 

```bash

minikube stop 
minikube delete

```


#### Deliverables:
+ Final validation report documenting the testing process and results

+ Cleanup commands/scripts

