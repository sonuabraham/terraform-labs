/*
resource "aws_s3_bucket" "moved_bucket" {
  bucket = "sonuabraham-moved-bucket-123456"
}
*/
module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.10.0"
  bucket  = "sonuabraham-moved-bucket-123456"
}

moved {
  from = aws_s3_bucket.moved_bucket
  to   = module.s3-bucket.aws_s3_bucket.this[0]
}
