provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-00ccbfda997c1cfb2"
  instance_type = "t2.micro"
}
