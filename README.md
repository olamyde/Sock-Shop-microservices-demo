1. I fork the git master branch to my profile.

2. I clone the GitHub master branch repository.

3.  Step-by-Step Guide
   Infrastructure as Code with Terraform
 
* Create a new directory for your Terraform files:
    mkdir aws-infrastructure-setup
    cd aws-infrastructure-setup
   
## Step:-1 Setting Up the Kubernetes Cluster
* Initialize your Terraform project:
  <b>terraform init</b>
* Create a main.tf file with the following content to define VPC, subnets, and networking components:
  ![vpc-subnets-networking](https://github.com/user-attachments/assets/9c0592bb-f85a-425c-a36c-f85b523db33f)
* Apply the Terraform configuration:
  <b>terraform apply</b>
* VPC configured in the aws cloud:
  ![vpc-created](https://github.com/user-attachments/assets/7d764783-f388-4a42-9add-1e47db9c508d)
* Public-subnet and Private-subnet created:
  ![public private-subnet](https://github.com/user-attachments/assets/b1639eac-2e73-4002-9a02-d7b715f7a85a)
* Public route table created:
 ![public-route-table](https://github.com/user-attachments/assets/49bdb711-eceb-46db-969c-5ff0e4560117)
* Internet gateway created:
  ![Main-internet-gateway](https://github.com/user-attachments/assets/89e1763f-8b83-4ba1-af51-b4b612c0d769)
## Step 2: IAM Roles and Policies
* Create a iam.tf file to define IAM roles and policies for EKS, RDS, and other AWS services:
  ![IAM-Roles Policies](https://github.com/user-attachments/assets/1a6c5de0-40bc-4837-ad4c-726894676da2)
* Apply the IAM role configuration:
  <b>terraform apply</b>
## Step 3: Creating an EKS Cluster
* Add the following to your main.tf to create an EKS cluster with auto-scaling node groups:





  
  



