# Terraform-Lab-1
First Terraform Lab using Ubuntu I7 Laptop, Ubuntu workstation, AWS EC2 and S3 Bucket

Terraform Testbed Lab Overview
High-Level Overview of Steps
This lab set up a Terraform testbed to manage AWS cloud resources (S3 bucket) and local Docker resources ([Nginx](https://vishnu.hashnode.dev/nginx-cheatsheet) container) using my Laptop (Razer Blade, Ubuntu) and Workstation (Ubuntu mini PC, “Jarvis1”, 32GB RAM, 1TB SSD), with an AWS EC2 instance in the mix. 

Here’s what I did, where, and what was needed to get Terraform running:
1. Install and Configure Terraform (Laptop)

Location: Laptop (Razer Blade, Ubuntu)
Steps:
Installed Terraform via apt.
Verified with terraform -version.


Requirements:
Ubuntu package manager (apt) or internet access for downloading Terraform binary.
Sudo permissions for system-wide installation.

Purpose: Terraform is the core tool for defining and deploying infrastructure as code (IaC).

2. Install and Configure AWS CLI (Laptop)

Location: Laptop
Steps:
Hit a snag with apt install awscli (package not found).
Installed AWS CLI v2 using the official installer:curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

Configured with aws configure using AWS Access Key ID, Secret Key, region (e.g., us-east-1), and output format (json).
Tested with aws sts get-caller-identity.

Requirements:
curl, unzip, and internet access.
AWS account with IAM user credentials (Access Key/Secret Key).
IAM permissions for S3 (AmazonS3FullAccess) and optionally EC2.

Purpose: AWS CLI authenticates Terraform to manage AWS resources.

3. Install and Configure Docker (Workstation)

Location: Workstation (Jarvis1)
Steps:
Installed Docker:sudo apt install -y docker.io
sudo usermod -aG docker $USER
sudo systemctl enable docker --now

Enabled remote access on port 2375 for Terraform’s Docker provider:
Edited /usr/lib/systemd/system/docker.service, setting:ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375

Fixed a syntax error (tcp:0.0.0.0:2375 missing //).
Restarted Docker: sudo systemctl restart docker.

Secured port 2375 with UFW:sudo ufw allow from <laptop_ip> to any port 2375

Tested remote access from Laptop:curl http://<workstation_ip>:2375/version

Requirements:
Ubuntu with apt and internet access.
Sudo permissions.
Network connectivity between Laptop and Workstation (same LAN).

Purpose: Docker runs containers (e.g., Nginx) managed by Terraform.

4. Create and Deploy Terraform Config (Laptop)

Location: Laptop
Steps:
Created terraform-testbed directory: mkdir ~/terraform-testbed.
Wrote main.tf to manage:
AWS S3 bucket with a unique name using random_string.
Docker Nginx container on Workstation.

Fixed provider error (hashicorp/docker → kreuzwerker/docker).
Resolved S3 naming issue (added upper = false to random_string).
Fixed Docker port conflict (changed from 8080 to 8081).
Ran Terraform commands:
terraform init
terraform plan
terraform apply

Verified:
S3 bucket in AWS Console.
Nginx at http://<workstation_ip>:8081 and docker ps on Workstation.

Cleaned up with terraform destroy.

Requirements:
Terraform and AWS CLI installed.
Text editor (e.g., nano).
Network access to Workstation’s Docker daemon (port 2375).
AWS credentials and permissions.

Purpose: Deployed and managed cloud and local resources, showcasing IaC skills.

5. Troubleshooting (Laptop and Workstation)

Locations: Both
Steps:
Fixed AWS CLI install error on Laptop.
Debugged Docker service failure on Workstation (syntax in docker.service).
Resolved Terraform errors (provider source, S3 naming, port conflict).

Requirements:
Access to logs (systemctl status, journalctl).
Basic Linux skills for file editing and process management.

Purpose: Built troubleshooting skills for real-world IaC challenges.

What’s Needed to Get Terraform Running

Laptop:
Software: Terraform, AWS CLI, text editor.
Access: Internet, AWS credentials, network connectivity to Workstation.
Permissions: Sudo for installs, IAM permissions for AWS.

Workstation:
Software: Docker.
Access: Network reachable from Laptop (port 2375).
Permissions: Sudo for Docker config and firewall.

AWS:
Active account with IAM user/role.
Permissions for S3, EC2, etc.
Optional: .pem key pair for EC2 SSH access.
