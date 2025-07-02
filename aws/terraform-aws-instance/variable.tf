variable "ami_id" {
    type = string
    default = "mi-09c813fb71547fc4f"
    description = "AMI ID of the EC2 instance"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "Instance size"

    validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Valid values for instance-type are (t3.micro, t3.small, t3.medium)."
  } 
  
}

#Mandatory to provide
variable "sg_ids" {
    type = list 

}

variable "tags" {
    type = map 

}