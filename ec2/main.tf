#security group
resource "aws_security_group" "webserver_access" {
        name = "webserver_access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }


}

resource "aws_instance" "ourfirst" {
  ami           = "ami-00bb6a80f01f03502"
  availability_zone = "ap-south-1b"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.webserver_access.name}"]
  key_name = "EC2 KEYPAIR"
  user_data = filebase64("install_apache.sh")
  tags = {
    Name  = "ec2-test"
    Location = "Mumbai"
  }

}
