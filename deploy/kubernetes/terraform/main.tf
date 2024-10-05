provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "k8s-security-group" {
  name        = "md-k8s-security-group"
  vpc_id      = "vpc-042d493d90cf28df9"
  description = "allow all internal traffic, ssh, http from anywhere"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9411
    to_port     = 9411
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30002
    to_port     = 30002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 31601
    to_port     = 31601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ci-sockshop-k8s-master" {
  instance_type   = var.master_instance_type
  ami             = lookup(var.aws_amis, var.aws_region)
  key_name        = var.key_name
  security_groups = [aws_security_group.k8s-security-group.name]
  
  tags = {
    Name = "ci-sockshop-k8s-master"
  }


 connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

   provisioner "remote-exec" {
    inline = [
      # Install Docker
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt-get update -y && sudo apt-get install -y docker.io",

      # Install kubeadm, kubelet, and kubectl
      "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "sudo apt-add-repository 'deb http://apt.kubernetes.io/ kubernetes-xenial main'",
      "sudo apt-get update -y",
      "sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni",

      # Initialize the Kubernetes master node
      "sudo kubeadm init --pod-network-cidr=10.244.0.0/16",

      # Set up kubeconfig for the ubuntu user
      "mkdir -p /home/ubuntu/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config",
      "sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config",

      # Install a pod network (Flannel in this case)
      "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
    ]
  }
}

resource "aws_instance" "ci-sockshop-k8s-node" {
  instance_type   = var.node_instance_type
  count           = var.node_count
  ami             = lookup(var.aws_amis, var.aws_region)
  key_name        = var.key_name
  security_groups = [aws_security_group.k8s-security-group.name]

  tags = {
    Name = "ci-sockshop-k8s-node"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      # Install Docker
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt-get update -y && sudo apt-get install -y docker.io",

      # Install kubeadm, kubelet, and kubectl
      "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "sudo apt-add-repository 'deb http://apt.kubernetes.io/ kubernetes-xenial main'",
      "sudo apt-get update -y",
      "sudo apt-get install -y kubelet kubeadm kubectl",
      "sudo sysctl -w vm.max_map_count=262144"
    ]
  }
}



