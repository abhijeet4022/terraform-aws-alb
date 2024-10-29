# Sending the ALB output
output "alb" {
  value = aws_lb.main
}

# Sending listener output
output "listener" {
  value = aws_lb_listener.main
}