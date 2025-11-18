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
  profile                 = "default"
  region                  = "${local.env_vars.region}"
  shared_credentials_file = "/home/sonu/.aws/credentials"
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
EOF
}

inputs = {
  ami           = "data.aws_ami.latest.id"
  instance_type = local.shared_vars.instance_type
  tags = {
    Name = "Terragrunt Tutorial EC2"
  }
}
