resource "aws_instance" "roboshop" {
  //count = 4
  for_each = var.instances
  //for_each = toset(var.instances) //This converts list to map
  ami                    = var.ami_id
  //instance_type          = var.environment == "dev" ? "t3.micro" : "t3.small"
  instance_type          = each.value    
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  //subnet_id = "" - Optional
  //key_name = "" - Optional

  //tags = var.ec2_tags

  tags = {
    //Name = var.instances[count.index]
    Name = each.key
  }
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


