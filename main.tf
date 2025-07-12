# Provider configuration for AWS
provider "aws" {
  region = var.aws_region
}

# Create an S3 bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = "${var.bucket_prefix}-${random_string.suffix.result}"
  tags = {
    Name = "TerraformTestBucket"
  }
}

# Random string for unique bucket names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# Provider configuration for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

# Pull Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Run Nginx container
resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-test"
  ports {
    internal = 80
    external = 8081
  }
}
