#!/bin/bash

# Install Terraform
sudo apt update
sudo apt install -y terraform

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
aws --version

# Initialize and apply Terraform
terraform init
terraform apply -auto-approve
