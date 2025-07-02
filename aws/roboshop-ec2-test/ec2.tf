module "ec2" {
    source = "../terraform-aws-instance"
    #sg_ids = ["sg-094f253cd653f2dcb"]
    sg_ids = var.security_group_ids
    instance_type = var.instance_type

    /* tags = {
        Name = "roboshop-cart"
    } */

    tags = var.ec2_tags
  
}

