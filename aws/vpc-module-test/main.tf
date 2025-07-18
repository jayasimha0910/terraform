module "vpc" {
    #source = "../terraform-aws-vpc"
    source = "git::https://github.com/jayasimha0910/terraform.git//aws/terraform-aws-vpc?ref=main"
    /* project = "roboshop"
    environment = "dev"
    public_subnet_cidrs = ["10.0.1.0/24","10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.11.0/24","10.0.12.0/24"]
    database_subnet_cidrs = ["10.0.21.0/24","10.0.22.0/24"] */
    project = var.project
    environment = var.environment
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs

    is_peering_required = true
  
}