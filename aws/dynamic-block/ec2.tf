resource "aws_instance" "roboshop" {
  ami                    = var.ami_id
  instance_type          = var.intsnace_type
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  //subnet_id = "" - Optional
  //key_name = "" - Optional

  tags = var.ec2_tags
}


resource "aws_security_group" "allow_all" {
  name        = var.sg_name
  description = var.sg_description

  tags = var.sg_tags

  /* ingress {
    description      = "Allow all traffic" //optional
    from_port        = var.from_port                 // allows all traffic from all ports
    to_port          = var.to_port       // allows all traffic from all ports
    protocol         = "-1"              // -1 is used for allowing all protocols
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  } */

  /* ingress {
    description      = "Allow traffic from specific port" 
    from_port        = 22             
    to_port          = 22      
    protocol         = "-1"              
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow traffic from specific port" 
    from_port        = 80             
    to_port          = 80      
    protocol         = "-1"              
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
      description      = "Allow traffic from specific port" 
      from_port        = 443             
      to_port          = 443     
      protocol         = "-1"              
      cidr_blocks      = var.cidr_blocks
      ipv6_cidr_blocks = ["::/0"]
    } */

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = "-1"
      cidr_blocks      = var.cidr_blocks
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    description      = "Allow all traffic" // optional
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }
}


