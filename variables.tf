variable "aws_region" {
  description = "AWS region for resources"
  default     = "us-east-1"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  default     = "my-unique-test-bucket"
  type        = string
}

variable "docker_host" {
  description = "Docker daemon host for remote management"
  default     = "" # No default for security
  type        = string
}
