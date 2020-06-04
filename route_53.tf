#      _____             _         _____ ____  
#     |  __ \           | |       | ____|___ \ 
#     | |__) |___  _   _| |_ ___  | |__   __) |
#     |  _  // _ \| | | | __/ _ \ |___ \ |__ < 
#     | | \ \ (_) | |_| | ||  __/  ___) |___) |
#     |_|  \_\___/ \__,_|\__\___| |____/|____/

# concourse.jasonmorsley.io

# https://www.terraform.io/docs/providers/aws/r/route53_zone.html

data "aws_route53_zone" "jasonmorsley-io" {

  name         = var.domain
  private_zone = false

}

# https://www.terraform.io/docs/providers/aws/r/route53_record.html

resource "aws_route53_record" "a-record" {

  zone_id = data.aws_route53_zone.jasonmorsley-io.zone_id
  name    = var.sub_domain # concourse -> concourse.jasonmorsley.io
  type    = "A"
  ttl     = 300
  records = [module.concourse-node-1-ec2.public_ip]

}

output "route_53_name_servers" {
  value = data.aws_route53_zone.jasonmorsley-io.name_servers
}