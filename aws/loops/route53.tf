resource "aws_route53_record" "www" {
  count = 4
  zone_id = var.zone_id
  name    = "${var.instances[count.index]}.${var.domain_name}" #monogdb.trishulpictures.shop
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[count.index].private_ip]
}