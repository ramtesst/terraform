provider "aws" {
    region="us-east-1"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "department" {
  description = "Department tag"
}

variable "private_key" {
	description = "enter your private key"
}

resource "aws_instance" "machine1" {
    ami           = "ami-04b9e92b5572fa0d1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"

    tags = {
        department = var.department
    }

    connection {
      # The default username for our AMI
      user = "centos"
      private_key = var.private_key
      host = self.public_ip
      # The connection will use the local SSH agent for authentication.
    }

    provisioner "remote-exec" {
      inline = [
        "sudo yum update -y",
        "sudo yum install epel-release -y",
        "sudo yum install httpd -y",
        "sudo yum install ansible -y",
        "sudo /usr/sbin/service httpd start",
        "sudo yum install php -y",
        "sudo yum install php-mysql -y",
        "sudo /usr/sbin/chkconfig httpd on",
        "sudo yum install firewalld -y",
  #      "sudo service firewalld start && sudo firewall-cmd --zone=public --add-port=80/tcp --permanent && sudo firewall-cmd --zone=public --add-port=22/tcp --permanent && sudo firewall-cmd --reload",
        "cd /tmp/",
        "sudo curl -O https://raw.githubusercontent.com/vmeoc/Tito/master/asset/Deployment/Ansible/tito-fe-git.yml",
        "sudo ansible-playbook tito-fe-git.yml -e git_url=https://github.com/vmeoc/Tito/ -e tito_release=V1.9",
      ]
    }
}

resource "aws_instance" "machine2" {
    ami           = "ami-04b9e92b5572fa0d1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"

    tags = {
        department = var.department
    }
}

output "instance_ip_addr" {
  value = aws_instance.machine1.*.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.machine1.*.private_ip
}

output "instance_state" {
  value = aws_instance.machine1.instance_state
}
