# create infrastruture using terraform 
resource "aws_key_pair" "my-key" {
  key_name   = var.aws_key_name
  public_key = file("/home/sumeru-chougule/AWS-DevOps/OTT-platform-deployment/terraform-code/ec2-server/ott-deployment.pub")
}
# step 1 : create security group 
resource "aws_default_vpc" "default" {

  tags = {
    name = "default vpc"
  }
}


resource "aws_security_group" "my-sg" {
  name        = "ott-deployment-sg"
  description = "this is jenkins server sg"

  #define inbound and outbound rule
  #port 22 required for ssh access
  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #port 80 required for http
  ingress {
    description = "HTTP port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # port 443 required for https
  ingress {
    description = " HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #port 2379-2380 is required for etcd-cluster
  ingress {
    description = "etcd-cluster"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #port 3000 required for grafana
  ingress {
    description = " Grafana port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #port 8080 required for jenkins server
  ingress {
    description = " HTTPS port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # port 6443 is required for kube api server
  ingress {
    description = " Kube API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9000 is required for SonarQube
  ingress {
    description = "SonarQube Port"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9090 is required for Prometheus
  ingress {
    description = "Prometheus Port"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9100 is required for Prometheus metrics server
  ingress {
    description = "Prometheus Metrics Port"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 10250-10260 is required for K8s
  ingress {
    description = "K8s Ports"
    from_port   = 10250
    to_port     = 10260
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 30000-32767 is required for NodePort
  ingress {
    description = "K8s NodePort"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #define outboud rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }

  tags = {
    name = "ott-deployment"
  }
}
