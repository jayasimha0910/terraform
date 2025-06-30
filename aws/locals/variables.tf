variable "project" {
    default = "Roboshop"
}

variable "environment" {
    default = "Development"
}

variable "component" {
    default = "Cart"
}

# variable "final-name" {
#     default = "${var.project}-${var.environment}-${var.component}"
# }

variable "common_tags" {
  default = {
    Project   = "Roboshop"
    Terraform = "True"
  }
}


