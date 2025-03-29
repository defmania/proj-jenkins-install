### ***TERRAFORM STATE FILE MANAGEMENT***

This project contains a folder called s3-dynamodb. Inside the folder there is a terraform main.tf file. The role of this file is to create an S3 bucket and DynamoDB table for state file management for the whole project. 
You will find parts of the code already commented out. The reason why the backend is commented out is because of the classic "chicken and egg" terraform state file issue. This means, your will create the resources for hosting the state file, and for state file locking (S3 bucket and DynamoDB table), however you cannot use these to store the current state file. To resolve this situation you create the resources first, and then uncomment the backend code block and run terraform init again. You will have the option to migrate the state file. Go for it. It will migrate the state file to the remote backend.



### ***PROJECT TO DEPLOY JENKINS SERVER***

This project deploys infrastructure in AWS for running a Python Flask API app.

 --> It creates a VPC with subnets, route tables, internet gateway, security groups;

 --> it creates an EC2 instance in your VPC in the and uses user data to install Jenkins and Terraform on the instance
 
 --> it creates a certificate in ACM to be used with our LB and an A record for your app FQDN in Route53 (in a hosted zone of your preference)
 
 --> it creates an Application Load Balancer and a Target Group which contains the created EC2 instance



### ***REPLACING PLACEHOLDERS AND VARIABLES***


In ./backend.tf make sure you fill in the details for the backend configuration you currently have:

 --> bucket name

 --> bucket key
 
 --> region
 
 --> dynamodb table name

In ./variables.tf make sure you replace/check values for:

 --> vpc_cidr (default 10.20.0.0/16) -> CIDR used by your VPC
 
 --> vpc_name (default my-app-project-vpc) -> name of VPC
 
 --> availability_zones (default set to us-east-1a, us-east-1b) -> AZs used by LB, EC2 instances, etc.
 
 --> cidr_private_subnet (default 10.20.1.0/24, 10.20.2.0/24) -> private subnet CIDRs
 
 --> cidr_public_subnet (default 10.20.3.0/24, 10.20.4.0/24) -> public subnet CIDRs
 
 --> instance_name (default app-node-01) -> EC2 instance name
 
 --> instance_type (default t2.micro) -> EC2 instance type
 
 --> public_key -> used for SSH connection to EC2 instance
 
 --> enable_associate_public_ip_address -> Public IP association for instance
 
 --> lb_target_group_name (default jenkins-lb-target-group) -> Load balancer target group name
 
 --> lb_target_group_port (default 8080) -> Port used by Jenkins server
 
 --> lb_target_group_protocol (default HTTP)
 
 --> hostname (default jenkins.mydomain.com) -> Jenkins server FQDN
 
 --> key_name (default jenkins-key -> Jenkins server key name)
 
 --> hosted_zone (default mydomain.com) -> your hosted zone in AWS. the hosted-zone module assumes you already have a hosted zone in your AWS account.
