resource "aws_security_group" "vprofile-bean-elb-sg" {
  name        = "vprofile-bean-elb-sg"
  description = "SG for ELB"
  vpc_id      = module.ksh-vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ELB" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ELB" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_fromELB" {
  security_group_id           = aws_security_group.vprofile-bean-elb-sg.id
  referenced_security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  from_port                   = 80
  ip_protocol                 = "tcp"
  to_port                     = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-bean-elb-sg" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-bean-elb-sg" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#-------------------------------------------------------------------
resource "aws_security_group" "vprofile-bastion-sg" {
  name        = "vprofile-bastion-sg"
  description = "SG for bastion host"
  vpc_id      = module.ksh-vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "allow_https_BastonHost" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-bastion-sg" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-bastion-sg" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#------------------------------------------------------------------------
resource "aws_security_group" "vprofile-beaninst-sg" {
  name        = "vprofile-beaninst-sg"
  description = "SG for bean stack instance"
  vpc_id      = module.ksh-vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "ssh-frm-anywhere-beaninst" {
  security_group_id = aws_security_group.vprofile-beaninst-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-beaninst" {
  security_group_id = aws_security_group.vprofile-beaninst-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-beaninst" {
  security_group_id = aws_security_group.vprofile-beaninst-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#-----------------------------------------------------------------------------
resource "aws_security_group" "vprofile-backend-sg" {
  name        = "vprofile-backend-sg"
  description = "SG for backend"
  vpc_id      = module.ksh-vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "AllowAllFromBeanInstance" {
  security_group_id           = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-beaninst-sg.id
  from_port                   = 0
  ip_protocol                 = "tcp"
  to_port                     = 65535
}

resource "aws_vpc_security_group_ingress_rule" "AllowAllBackendToInterract" {
  security_group_id           = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-backend-sg.id
  from_port                   = 0
  ip_protocol                 = "tcp"
  to_port                     = 65535
}

resource "aws_vpc_security_group_ingress_rule" "Allow3306FromBastionHost" {
  security_group_id           = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-bastion-sg.id
  from_port                   = 3306
  ip_protocol                 = "tcp"
  to_port                     = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-backend-sg" {
  security_group_id = aws_security_group.vprofile-backend-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-backend-sg" {
  security_group_id = aws_security_group.vprofile-backend-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





