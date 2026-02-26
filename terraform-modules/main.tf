provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}

module "sg" {
  source = "./modules/network"
  providers = {
    aws.prod = aws.sydney
  }
}
