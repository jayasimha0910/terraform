module "frontend" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/jayasimha0910/terraform.git///aws/terraform-aws-sg?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id      = local.vpc_id
  
}

module "bastion" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/jayasimha0910/terraform.git///aws/terraform-aws-sg?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id      = local.vpc_id
  
}


#SG Rule for Bastion Host
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id 
}