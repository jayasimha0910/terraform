variable "project" {
  default = "roboshop"
}

variable "environment" {

}

variable "common_tags" {
  default = {
    Project   = "roboshop"
    Terraform = "true"
  }
}

variable "sg_name" {
  default = "allow-all"

}

variable "sg_description" {
  default = "Allowing from all ports"

}

variable "instances" {
  default = ["mongodb", "redis"]

}

variable "ami_id" {
  default = "ami-09c813fb71547fc4f"

}

variable "instance_type" {
 
}
variable "from_port" {
  default = 0

}

variable "to_port" {
  default = 0

}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
  
}


