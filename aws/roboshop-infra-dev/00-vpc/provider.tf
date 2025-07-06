terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket = "84s-remote-state-jay"
    key    = "roboshop-infra-dev-vpc"
    region = "us-east-1"
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}