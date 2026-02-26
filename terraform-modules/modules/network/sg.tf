terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.prod]
    }


  }
}
resource "aws_security_group" "dev" {
  name = "dev-sg"
}

resource "aws_security_group" "prod" {
  name     = "prod-sg"
  provider = aws.prod
}
