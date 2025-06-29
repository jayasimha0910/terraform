resource "aws_instance" "roboshop" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  //subnet_id = "" - Optional
  //key_name = "" - Optional

  tags = {
    Name = "My First Instance"
  }
}



resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all Inbound and Outbound traffic"

  tags = {
    Name = "allow_all"
  }
  
  ingress {
    description      = "Allow all traffic" //optional
    from_port        = 0                 // allows all traffic from all ports
    to_port          = 0                 // allows all traffic from all ports
    protocol         = "-1"              // -1 is used for allowing all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all traffic"  // optional
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


