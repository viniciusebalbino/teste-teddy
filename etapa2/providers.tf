terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "teddy-tfstates-bucket"
    key            = "teddy_test_env/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
}
