locals {
  # Tags
  tags = merge(var.tags, { module-name = "alb" }, { env = var.env })
  load_balancer_name = var.internal ? "${var.env}-internal-alb" : "${var.env}-public-alb"
  sg_name = var.internal ? "${var.env}-internal-alb-sg" : "${var.env}-public-alb-sg"
}