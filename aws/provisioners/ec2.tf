resource "aws_instance" "roboshop" {
  ami                    = var.ami_id
  instance_type          = var.intsnace_type
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]

  provisioner "local-exec" {
    #command = "${self.private_ip} > inventory" - this will fail
    command = "echo ${self.private_ip} > inventory"
    when = create
    on_failure = continue //used to continue next step on failure as well
  }

  provisioner "local-exec" {
    command = "echo 'Instance is getting destroyed'"
    when = destroy
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y ",
      "sudo systemctl start nginx",
    ]
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
  }

  //subnet_id = "" - Optional
  //key_name = "" - Optional

  tags = var.ec2_tags
}


resource "aws_security_group" "allow_all" {
  name        = var.sg_name
  description = var.sg_description

  tags = var.sg_tags
  
  ingress {
    description      = "Allow all traffic" //optional
    from_port        = var.from_port                 // allows all traffic from all ports
    to_port          = var.to_port       // allows all traffic from all ports
    protocol         = "-1"              // -1 is used for allowing all protocols
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all traffic"  // optional
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }
}


