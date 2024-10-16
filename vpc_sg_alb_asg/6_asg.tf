# Create launch Template
resource "aws_launch_template" "web_server_launch_template" {
  name          = "${var.environment}-launch-template"
  description   = "Dev Launch Template for ASG"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/userdata.sh")
  monitoring {
    enabled = true
  }
  lifecycle {
    create_before_destroy = true
  }
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]

}

# Create Auto scaling Group
resource "aws_autoscaling_group" "auto_scaling_group" {
  name                = "${var.environment}-Auto Scaling Group"
  vpc_zone_identifier = aws_subnet.private_subnets[*].id
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  health_check_type   = "ELB"
  launch_template {
    id      = aws_launch_template.web_server_launch_template.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${var.environment}-Webserver"
    propagate_at_launch = true
  }
}

# Attach auto scaling group to alb target group
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}