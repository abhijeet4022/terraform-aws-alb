# Create the ALB
resource "aws_lb" "main" {
  name               = local.load_balancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets
  tags               = merge(local.tags, { Name = local.load_balancer_name })
}


# SG for ALB.
resource "aws_security_group" "lb_sg" {
  name        = local.sg_name
  description = local.sg_name
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = local.sg_name })
}


# Ingress rule for ALB SG.
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = toset(var.cidr_block) # Convert list to a set to iterate over each CIDR
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = each.value  # Each CIDR block as a separate rule
  from_port         = var.sg_port
  ip_protocol       = "tcp"
  to_port           = var.sg_port
}


# Ingress rule for Public ALB SG.
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  count             = var.internal ? 0 : 1
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = ["0.0.0.0/0"]  # Each CIDR block as a separate rule
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}


# Egress rule for ALB SG.
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

