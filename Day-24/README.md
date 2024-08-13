# Comprehensive AWS S3 Management and Static Website Hosting

## Objective:

To test your knowledge and skills in managing AWS S3 storage classes, lifecycle management, bucket policies, access control lists (ACLs), and hosting a static website on S3. You will apply their understanding in a practical scenario, ensuring you have mastered the critical aspects of AWS S3.

## Project Scenario:

You are tasked with creating and managing an S3 bucket for a fictional company, "TechVista Inc.," that hosts a static website for displaying their product portfolio. The website will have different types of content, including high-resolution images, which require careful storage management to optimize costs. Additionally, the company has strict security requirements for accessing the content.

### Project Steps and Deliverables:

1. Create and Configure an S3 Bucket:

    + Create an S3 bucket named techvista-portfolio-[your-initials].

        ![alt text](images/image.png)

    + Enable versioning on the bucket.

        ![alt text](images/image-1.png)

        ![alt text](images/image-2.png)

        ![alt text](images/image-3.png)

        ![alt text](images/image-4.png)

    + Set up the bucket for static website hosting.

        Go to `Amazon S3` > `Buckets` > `techvista-portfolio-maaz-patel` > `Properties`

        ![alt text](images/image-6.png)


    + Upload the provided static website files (HTML, CSS, images).

        ![alt text](images/image-5.png)

        ![alt text](images/image-7.png)

    + Before we access the website we need to give public access to s3 bucket

        `Amazon S3` > `Buckets` > `techvista-portfolio-maaz-patel` > `Permissions`

        ![alt text](images/image-8.png)

    + Create Bucket policy

        ```json
        {
        	"Version": "2012-10-17",
        	"Statement": [
        		{
        			"Sid": "Statement1",
        			"Principal": "*",
        			"Effect": "Allow",
        			"Action": "s3:GetObject",
        			"Resource": "arn:aws:s3:::techvista-portfolio-maaz-patel/*"
        		}
        	]
        }
        ```

        ![alt text](images/image-9.png)

        ![alt text](images/image-10.png)


    + Ensure the website is accessible via the S3 website URL.

        `URL` : https://techvista-portfolio-maaz-patel.s3.amazonaws.com/index.html

        ![alt text](images/image-11.png)

2. Implement S3 Storage Classes:

    + Classify the uploaded content into different S3 storage classes (e.g., Standard, Intelligent-Tiering, Glacier).

        `Amazon S3` > `Buckets` > `techvista-portfolio-maaz-patel` > `Upload`

        Under Properties we have list of options of Storage Class to which specific object be store.

        ![alt text](images/image-12.png)

        This way when uploading any file we can give to which storage class it should be depolyed


    + Justify your choice of storage class for each type of content (e.g., HTML/CSS files vs. images).

        + As curently we are working with HTML/CSS files, images, which are going to be frequently accessed. So we they are stored in Standerd Storage Class.

3. Lifecycle Management:

    + Create a lifecycle policy that transitions older versions of objects to a more cost-effective storage class (e.g., Standard to Glacier).

        `Amazon S3` > `Buckets` > `techvista-portfolio-maaz-patel` > `Management`

        ![alt text](images/image-13.png)

        Create new Lifecycle rule

        ![alt text](images/image-14.png)

    + Set up a policy to delete non-current versions of objects after 90 days.

        ![alt text](images/image-15.png)
        
    + Verify that the lifecycle rules are correctly applied.        

        ![alt text](images/image-16.png)

4. Configure Bucket Policies and ACLs:

    + Create and attach a bucket policy that allows read access to everyone for the static website content.

        Policy

        ```json
        {
        	"Version": "2012-10-17",
        	"Statement": [
        		{
        			"Sid": "Statement1",
        			"Principal": "*",
        			"Effect": "Allow",
        			"Action": "s3:GetObject",
        			"Resource": "arn:aws:s3:::techvista-portfolio-maaz-patel/*"
        		}
        	]
        }
        ```

    + Restrict access to the S3 management console for specific IAM users using the bucket policy.


        ```json
        {
        	"Version": "2012-10-17",
        	"Statement": [
        		{
        			"Sid": "Statement1",
        			"Principal": "arn:aws:iam::326151034032:user/<user-name>",
        			"Effect": "Deny",
        			"Action": "s3:GetObject",
        			"Resource": "arn:aws:s3:::techvista-portfolio-maaz-patel/*"
        		},

                {
        			"Sid": "Statement2",
        			"Principal": "*",
        			"Effect": "Allow",
        			"Action": "s3:GetObject",
        			"Resource": "arn:aws:s3:::techvista-portfolio-maaz-patel/*"
        		}
        	]
        }
        ```

    + Set up an ACL to allow a specific external user access to only a particular folder within the bucket.

        `Amazon S3` > `Buckets` > `techvista-portfolio-maaz-patel` > `Permissions`

        ![alt text](images/image-17.png)

        ![alt text](images/image-18.png)


5. Test and Validate the Configuration:

    + Test the static website URL to ensure it is accessible.

        `URL` : https://techvista-portfolio-maaz-patel.s3.amazonaws.com/index.html

        ![alt text](images/image-11.png)