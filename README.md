# Terraform Lab 1: AWS S3 and Docker Nginx Testbed

## Overview
This repository demonstrates a Terraform testbed managing cloud and local resources:
- **AWS S3 Bucket**: Deployed a uniquely named S3 bucket in AWS.
- **Docker Nginx Container**: Ran an Nginx web server on a local Ubuntu workstation.
- **Purpose**: Built to practice infrastructure as code (IaC) for job search preparation, showcasing Terraform, AWS, and Docker skills.

## Architecture
- **Laptop (Ubuntu)**: Ran Terraform and AWS CLI to manage resources.
- **Workstation (Ubuntu, 32GB RAM, 1TB SSD)**: Hosted Docker containers, accessed remotely via port 2375.
- **AWS**: Hosted S3 bucket; supports EC2 for future extensions.

## Setup and Deployment
1. **Installed Tools** (Laptop):
   - Terraform for IaC.
   - AWS CLI for cloud authentication.
2. **Configured Docker** (Workstation):
   - Enabled remote access on port 2375 with firewall restrictions.
3. **Wrote Terraform Config** (Laptop):
   - `main.tf`: Defined S3 bucket and Nginx container.
   - `variables.tf`: Parameterized inputs for reusability.
4. **Deployed and Verified**:
   - Ran `terraform init`, `plan`, `apply`.
   - Verified S3 bucket in AWS Console and Nginx at `http://<your_docker_host_ip>:8081`.

## Troubleshooting Highlights
- **AWS CLI Install**: Fixed missing `awscli` package by using AWS’s official installer.
- **Docker Service**: Resolved daemon failure by correcting `systemd` config syntax.
- **Terraform Errors**:
  - Updated provider from `hashicorp/docker` to `kreuzwerker/docker`.
  - Fixed S3 bucket naming with lowercase random strings.
  - Resolved Docker port conflict by switching from 8080 to 8081.
  - **Terraform Provider Error**: Fixed duplicate AWS provider issue by consolidating into a single provider block.

## Files
- `main.tf`: Core Terraform config for AWS and Docker resources.
- `variables.tf`: Input variables for flexible configuration.
- `.gitignore`: Excludes sensitive Terraform and AWS files.
- `LICENSE`: MIT License for open-source sharing.
- `terraform.tfvars.example`: Template for configuration.
- `setup.sh`: Script to automate setup and deployment.
- `screenshots/`: Visual proof of deployment.

## How to Run
1. Clone this repo:
   ```bash
   git clone https://github.com/Cloud-Ops-Dev/Terraform-Lab-1.git
   cd Terraform-Lab-1
