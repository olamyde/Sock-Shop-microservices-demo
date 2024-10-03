  provider "aws" {
    region = "us-west-2"
  }

  resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "infrastructure-vpc"
    }
  }

  resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.main_vpc.id
    cidr_block        = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-west-2a"
    tags = {
      Name = "public-subnet"
    }
  }

  resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.main_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name = "private-subnet"
    }
  }

  resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      Name = "main-igw"
    }
  }

  resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main_vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "public-route-table"
    }
  }

  resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
  }

 module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  
  cluster_name    = "my-cluster"
  cluster_version = "1.30"
  cluster_endpoint_public_access  = true

  cluster_addons = {
    eks-pod-identity-agent = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = aws_vpc.main_vpc.id
  subnet_ids               = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
  

 eks_managed_node_groups = {
    eks_node = {
      instance_type = "t3.medium"
      key_name      = "my-key-pair"


      min_size     = 1
      max_size     = 3
      desired_size = 2

    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Name = "eks_node"
  }
}