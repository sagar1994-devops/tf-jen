# Create application load balancer
resource "aws_alb" "application_load_balancer" {
  name                       = "${var.environment}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_security_group.id]
  subnets                    = aws_subnet.public_subnets[*].id
  enable_deletion_protection = false

  tags = {
    Name = "${var.environment}-alb"
  }
}

# Create Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.environment}-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment}-Target Group"
  }
}

# Create listener on port 80 with forward action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}