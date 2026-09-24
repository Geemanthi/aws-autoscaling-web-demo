# Defines the EC2 launch configuration for NGINX application instances.
resource "aws_launch_template" "nginx" {
  name_prefix   = "lt-${var.name_suffix}"
  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(local.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        Name = "lt-${var.name_suffix}"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Maintains the desired number of NGINX instances across the private subnets.
resource "aws_autoscaling_group" "nginx" {
  name                = "asg-${var.name_suffix}"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.nginx.arn]

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type         = "ELB"
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-${var.name_suffix}"
    propagate_at_launch = true
  }
}
