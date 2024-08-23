Project - 14th August
======

### Deploying a Path-Based Routing Web Application on AWS

**Objective**

To evaluate your skills in deploying a web application on AWS using EC2 instances, configuring security groups, and setting up an Application Load Balancer (ALB) with path-based routing. You will deploy two simple web applications, configure the ALB to route traffic based on the URL path, and terminate all resources once the project is complete.

**Project Scenario:**

A small company needs to deploy two lightweight web applications, "App1" and "App2," on AWS. The traffic to these applications should be routed through a single Application Load Balancer (ALB) based on the URL path. The company has opted for t2.micro instances for cost efficiency.

## Project Steps and Deliverables:

### 1. EC2 Instance Setup :
- **Launch EC2 Instances:**

    - Launch four EC2 t2.micro instances using the Amazon Linux 2 AMI.
    ![alt text](img/image2.png)
    - SSH into each instance and deploy a simple web application:
        - Deploy "App1" on two instances.

        ![alt text](img/image3.png)
        ![alt text](img/image4.png)

        - Deploy "App2" on the other two instances.
        ![alt text](img/image6.png)
        ![alt text](img/image5.png)

    - Assign tags to the instances for identification (e.g., "App1-Instance1," App1-Instance2," "App2-Instance1," "App2-Instance2").

### 2. Security Group Configuration :
- **Create Security Groups:**

    - Create a security group for the EC2 instances that allows inbound HTTP (port 80) and SSH (port 22) traffic from your IP address.

    ![alt text](img/image1.png)

    - Create a security group for the ALB that allows inbound traffic on port 80.
    - Attach the appropriate security groups to the EC2 instances and ALB.
    ![alt text](img/image7.png)

### 3. Application Load Balancer Setup with Path-Based Routing :

- **Create an Application Load Balancer (ALB):**
    - Set up an ALB in the same VPC and subnets as your EC2 instances.
    - Configure the ALB with two target groups:
        - Target Group 1: For "App1" instances.

        ![alt text](img/image8.png)
        
        - Target Group 2: For "App2" instances.

        ![alt text](img/image9.png)
    
    - Register the appropriate EC2 instances with each target group.

- **Configure Path-Based Routing:**
    - Set up path-based routing rules on the ALB:
        - Route traffic to "App1" instances when the URL path is /app1.
        - Route traffic to "App2" instances when the URL path is /app2.

        ![alt text](img/image12.png)
        
    - Set up health checks for each target group to ensure that the instances are healthy and available.
### 4. Testing and Validation :
- **Test Path-Based Routing:**

Access the ALB's DNS name and validate that requests to /app1 are correctly routed to the "App1" instances and that /app2 requests are routed to the "App2" instances.

![alt text](img/image11.png)
![alt text](img/image10.png)

- **Security Validation:**

    - Attempt to access the EC2 instances directly via their public IPs to ensure that only your IP address can SSH into the instances.

- Removed the Public IP of the instances so that no one can access the web applications directly

![alt text](img/image13.png)

### 5. Resource Termination :
- **Terminate EC2 Instances:**

Stop and terminate all EC2 instances.

![alt text](img/image14.png)

- **Delete Load Balancer and Target Groups:**

Delete the ALB and the associated target groups.

![alt text](img/image15.png)
![alt text](img/image16.png)

- **Cleanup Security Groups:**

Delete the security groups created for the project.

![alt text](img/image17.png)

### 6. Documentation and Reporting :
- **Brief Documentation:**

Document the steps taken during the project, including the setup of EC2 instances, security groups, and ALB configuration.
[README.md](README.md)

- **Final Report:**

Summarize the project, highlighting any challenges faced and how they were resolved.
