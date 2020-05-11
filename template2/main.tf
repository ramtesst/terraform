resource "aws_instance" "ubuntu" {
    ami           = "ami-04b9e92b5572fa0d1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
}

providers "aws" {
    region="us-east-1"
}