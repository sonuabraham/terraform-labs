terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=5.7.1"
}

locals {
  shared_vars = yamldecode(
    file("${find_in_parent_folders("shared-environment.yaml")}")
  )
  env_vars = yamldecode(
    file("prod-environment.yaml")
  )
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  profile = "default"
  region  = "${local.env_vars.region}"
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
EOF
}

inputs = {
  ami           = "ami-04246dd1e4b4e93c7"  # Amazon Linux 2 AMI in us-west-1
  instance_type = local.shared_vars.instance_type
  tags = {
    Name = "Terragrunt Tutorial EC2"
  }
}
