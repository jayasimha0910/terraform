locals {
  ami_id = data.aws_ami.joindevops.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id
  public_sbunet_id = split ("," , data.aws_ssm_parameter.public_sbunet_ids.value[0])

  common_tags = {
    Name = var.project
    Environment = var.environment
    Terraform = "True"
  }
}