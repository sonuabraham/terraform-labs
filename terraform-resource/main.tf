resource "aws_instance" "prod" {
  count         = 2
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = "t2.micro"

}

moved {
  from = aws_instance.refactor
  to   = aws_instance.prod
}
