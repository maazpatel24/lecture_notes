Assessment Project: End-to-End Deployment and Management of a Scalable E-Commerce Platform on AWS
======

**Objective:**

To evaluate your proficiency in designing, deploying, and managing a comprehensive and scalable e-commerce platform on AWS. The project will integrate multiple AWS services, including S3, EC2, Auto Scaling, Load Balancer, VPC (without NAT Gateway), and RDS. The platform must be highly available, secure, and optimized for performance.

**Project Scenario:**

You are tasked with deploying a scalable e-commerce platform for "ShopMax," an online retailer preparing for a major sales event. The platform needs to handle fluctuating web traffic, securely manage user and product data, and serve both dynamic and static content efficiently. The infrastructure should be cost-effective and secure, with high availability and fault tolerance.

## Project Steps and Deliverables:
### 1. VPC Design and Implementation :

- **Design a Custom VPC:**
    - Create a VPC with four subnets: two public subnets (for EC2 instances and Load Balancers) and two private subnets (for RDS and backend services).

<!-- vpc create -->
![alt text](img/image1.png)
<!-- subnet create -->

![alt text](img/image2.png)
<!-- route table create -->

![alt text](img/image3.png)
![alt text](img/image4.png)

- Set up an Internet Gateway to allow internet access for the public subnets.

![alt text](img/image5.png)
![alt text](img/image6.png)

- Configure routing tables to enable communication between the subnets, ensuring that the private subnets can only communicate with the public subnets.

- **Security Configuration:**
    - Create security groups to control inbound and outbound traffic for EC2 instances, Load Balancer, and RDS.
    - Implement network ACLs to add an additional layer of security at the subnet level.
![alt text](img/image9.png)

### 2. S3 Bucket Configuration for Static Content :

- **Create and Configure S3 Buckets:**
    - Create an S3 bucket named shopmax-static-content-chirag for hosting static assets (e.g., images, CSS, JavaScript).

<!-- S3 bucket with css and js files -->
![alt text](img/image12.png)

- Set appropriate bucket policies to allow public read access to the static content.

<!-- bucket policy -->
![alt text](img/image13.png)
![alt text](img/image14.png)

- Enable versioning and logging on the bucket for better management and auditability.

![alt text](img/image15.png)

- **Optimize Content Delivery:**
    - (Optional) Set up an S3 bucket for backups or archival purposes, using lifecycle rules to transition older files to cheaper storage classes like Glacier.

### 3. EC2 Instance Setup and Web Server Configuration :

- **Launch EC2 Instances:**
    - Launch a pair of EC2 instances (t2.micro ONLY) in the public subnets using an Amazon Linux 2 AMI.

<!-- Webserver Ec2 Instance -->
![alt text](img/image7.png)
<!-- Application Server Ec2 Instance -->
![alt text](img/image8.png)

- SSH into the instances and install a web server (Apache or Nginx) along with necessary application dependencies.

![alt text](img/image10.png)

- **Deploy the Application:**
    - Deploy the dynamic e-commerce application on both instances.

<!-- Installing Website and configuring it -->
![alt text](img/image11.png)

- Configure the web server to serve dynamic content and integrate with the static content hosted on S3.

```bash
# first unzip the file
unzip -v PhotoFolio.zip makefile -d webapp/
cd webapp/

# now copy all the .html files from webapp to the /var/www/html/webapp/
sudo mkdir -p /var/www/html/webapp
sudo cp *html /var/www/html/webapp/
cd /var/www/html/webapp

# change the configuration file of apache2 by using below steps
cd /etc/apache2/sites-available
sudo cp 000-default.conf webapp.conf
```
> webapp.conf file
```xml
<VirtualHost *:80>
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www/html/webapp

    ErrorLog ${APACHE_LOG_DIR}/webapp_error.log
    CustomLog ${APACHE_LOG_DIR}/webapp_access.log combined

    <Directory /var/www/html/webapp>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```
```bash
# after changing the config file of apache 2 use below commands
sudo a2dissite 000-default.conf
sudo a2ensite webapp.conf
sudo systemctl daemon-reload
sudo systemctl enable apache2
sudo systemctl restart apache2
```

<span style="color: red">
Change the paths of the css, js files and paths of all the images in all of the .html files with the path of objects in the s3 bucket <b>shopmax-static-content-chirag<b>
</span>

### 4. RDS Setup and Database Configuration :

- **Provision an RDS MySQL Instance:**
    - Launch an RDS instance (Free Tier Template Type, t3.micro ONLY) in the private subnets, ensuring that it is not publicly accessible.

    ![alt text](img/image34.png)
    
    - Configure the database schema to support the e-commerce application (e.g., tables for users, orders, products).
    - Set up automated backups to ensure high availability.
    ![alt text](img/image35.png)

- **Database Security:**

    - Implement security measures such as encryption at rest and in transit.
    - Restrict database access to only the EC2 instances in the public subnets via security groups.

    ![alt text](img/image36.png)

### 5. Load Balancer and Auto Scaling Configuration :

- **Set Up an Application Load Balancer (ALB):**
    - Deploy an ALB in the public subnets to distribute traffic across the EC2 instances.
    - Create a target group and register the EC2 instances, ensuring health checks are configured properly.

![alt text](img/image21.png)
![alt text](img/image22.png)
![alt text](img/image23.png)

- **Configure Auto Scaling:**

    - Before creating Auto Scaling group create launch template of Amazon Linux 2 AMI with t2 micro instance type

![alt text](img/image16.png)

- Create an Auto Scaling group that launches additional EC2 instances based on traffic patterns (e.g., CPU utilization). (Desired: 2, minimum:1 and maximum: 2 instances)

![alt text](img/image17.png)

- Define scaling policies to automatically add or remove instances based on demand.

![alt text](img/image18.png)

- **Testing the Setup:**
    - Simulate traffic to test the scalability and fault tolerance of the infrastructure.
    - Verify that the ALB is evenly distributing traffic and that the Auto Scaling group is working as expected.

![alt text](img/image19.png)
![alt text](img/image20.png)

### 6. Testing, Validation, and Optimization :

- **Full Application Test:**
    - Access the e-commerce application via the ALB DNS name and ensure that both static and dynamic content is being served correctly.

<!-- for /app1/ -->
![alt text](img/image24.png)
<!-- for /app2/ -->
![alt text](img/image25.png)

- Validate database connections and transactions (e.g., creating orders, adding products).
- Test the security configurations by attempting to access restricted resources and ensuring proper logging of unauthorized access attempts.

- **Optimization:**
    - Review the architecture and suggest any potential optimizations, such as improving response time, reducing costs, or enhancing security.

- **Cleanup:**
    - Terminate all the resources created i.e VPC, EC2 instances, Templates, target group, security group, private key-pair, RDS instances, Auto scaling group, Application Load Balancer

1. EC2 instances:<br>
![alt text](img/image26.png)

1. Auto Scaling group:<br>
![alt text](img/image27.png)

1. Application Load Balancer:<br>
![alt text](img/image28.png)

1. Target Groups:<br>
![alt text](img/image29.png)

1. Private Key pair:<br>
![alt text](img/image30.png)

1. Instance Templates:<br>
![alt text](img/image31.png)

1. RDS Database:<br>
![alt text](img/image37.png)

1. S3 bucket:<br>
![alt text](img/image32.png)

1. VPC, Route Tables, Subnets, Internet Gateway and Security Groups:<br>
![alt text](img/image33.png)

### 7. Documentation and Report :

- **Detailed Documentation:**
    - Document each step taken during the project, including VPC design, EC2 and RDS configurations, S3 setup, Load Balancer and Auto Scaling implementation, and security measures.
    - Provide screenshots and logs as evidence of configuration and testing.
    
<center style="cursor: pointer">
<a src=./README.md>README.md</a>
</center>

- **Final Report:**
    - Summarize the project, highlighting any challenges faced and how they were resolved.
    - Provide recommendations for future improvements or scaling strategies.
