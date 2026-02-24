variable "instance_type" {
  type = string
}

resource "aws_instance" "web" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = var.instance_type

  timeouts {
    create = "15m"
    update = "5m"
    delete = "20m"
  }

  lifecycle {
    precondition {
      condition     = can(regex("^t2\\.", var.instance_type))
      error_message = "Only t2 instance types are allowed."
    }
  }
}
