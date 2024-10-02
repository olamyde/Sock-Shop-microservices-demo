1. I fork the git master branch to my profile.

2. I clone the GitHub master branch repository.

3.  Step-by-Step Guide
   Infrastructure as Code with Terraform
 
* Create a new directory for your Terraform files:
    mkdir aws-infrastructure-setup
    cd aws-infrastructure-setup
   
   ## Step:-1 Setting Up the Kubernetes Cluster
* Initialize your Terraform project:
  terraform init
* Create a main.tf file with the following content to define VPC, subnets, and networking components:
  ![vpc-subnets-networking](https://github.com/user-attachments/assets/9c0592bb-f85a-425c-a36c-f85b523db33f)
* Apply the Terraform configuration:
  terraform apply

