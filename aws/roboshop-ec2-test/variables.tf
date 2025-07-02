variable "security_group_ids" {
    default = ["sg-094f253cd653f2dcb"]
  
}

variable "ec2_tags" {
    default = {
        Name = "roboshop-cart"
        Environment = "dev"
        Terraform = true
    }
  
}

variable "instance_type" {
    default = "t3.medium"
  
}