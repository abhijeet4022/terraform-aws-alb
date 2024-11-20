# Create the Listener for Load Balancer
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.internal ? "80" : 443
  protocol          = var.internal ? "HTTP" : "HTTPS"
  ssl_policy        = var.internal ? null : "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.internal ? null : var.acm


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ERROR"
      status_code  = "404"
    }
  }
}

#Create the Listener for Public LB to redirect the HTTP traffic to HTTPS.
resource "aws_lb_listener" "front_end" {
  count             = var.internal ? 0 : 1
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}