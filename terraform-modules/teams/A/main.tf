provider "aws" {
  region = "us-east-1"

}

module "ec2" {
  source        = "../../modules/ec2"
  instance_type = "t2.micro"
  ami           = "ami-051f7e7f6c2f40dc1"
}
