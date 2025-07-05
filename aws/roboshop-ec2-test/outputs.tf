output "pub_ip" {
    value = module.ec2.public_ip
  
}
output "pri_ip" {
    value = module.ec2.private_ip
  
}
output "ins_id" {
    value = module.ec2.instance_id
  
}


