terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket = "84s-remote-state-jay"
    key    = "workspace-demo"
    region = "us-east-1"
    # dynamodb_table = "84s-remote-state" -- This is depricated used native locking in s3 only
    encrypt      = true
    use_lockfile = true #S3 native locking
  }
}

provider "aws" {
  # Configuration options
}