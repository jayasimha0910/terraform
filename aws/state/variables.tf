variable "ami_id" {
  type        = string
  description = "AMI ID of join devops RHEL9"
  default     = "ami-09c813fb71547fc4f"
}

variable "intsnace_type" {
  type        = string
  default     = "t3.micro"
}

variable "ec2_tags" {
  type = map(string)
  default = {
    Name = "Hello World"
    Purpose = "Variables Demo"
  }
}

variable "sg_name" {
  type        = string
  default     = "allow_all"
}

variable "sg_description" {
  type        = string 
  default     = "Allow all Inbound and Outbound traffic"
}

variable "from_port" {
  type        = number
  default     = 0
}

variable "to_port" {
  type        = number
  default     = 0
}

variable "cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_tags" {
  default = {
    Name = "allow-all"
  }
  
}
