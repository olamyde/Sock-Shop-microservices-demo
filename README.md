1. I fork the git master branch to my profile.

2. I clone the GitHub master branch repository.

## 3. Step-by-Step Guide
   Infrastructure as Code with Terraform
 
* Create a new directory for Terraform files:
  ![mkdir](https://github.com/user-attachments/assets/62f74f05-f194-4509-8960-abc880abef63) 
   ## Step:-1 Setting Up the Kubernetes Cluster
* Initialize your Terraform project:
  ![terraform-init](https://github.com/user-attachments/assets/f153d101-a59a-4981-811b-8b552a61b887)

* Create a main.tf file with the following content to define VPC, subnets, and networking components:
  ![vpc-subnets-networking](https://github.com/user-attachments/assets/9c0592bb-f85a-425c-a36c-f85b523db33f)
* Apply the Terraform configuration:
  ![terraform-apply](https://github.com/user-attachments/assets/c2e930ec-09c6-4570-a5e9-cac608af7019)

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
  ![terraform-apply](https://github.com/user-attachments/assets/85f2f7a0-1561-4370-8706-dd2edb374d5d)

   ## Step 3: Creating an EKS Cluster
* Add the following to your main.tf to create an EKS cluster with auto-scaling node groups:
![EKS-Cluster](https://github.com/user-attachments/assets/dff33922-6b36-4191-82c9-e50a1f5685ac)
* Apply the EKS configuration:
  ![terraform-apply](https://github.com/user-attachments/assets/098af2eb-9f09-4749-977d-491235af915b)
* Kubernetes Cluster created:
  ![eks-cluster-ready](https://github.com/user-attachments/assets/555d8eaa-664b-4c11-b7ef-9ef43bae94cc)

  

  





  
  



