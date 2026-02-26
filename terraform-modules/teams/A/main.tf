provider "aws" {
  region = "us-east-1"

}

module "ec2" {
  source        = "../../modules/ec2"
  instance_type = "t2.micro"
  ami           = "ami-051f7e7f6c2f40dc1"
}

resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_eip_association" "this" {
  instance_id   = module.ec2.instance_id
  allocation_id = aws_eip.this.id
}
