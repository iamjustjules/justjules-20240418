resource "aws_launch_template" "app" {
  name_prefix   = "app-instance-"
  image_id      = "ami-051f8a213df8bc089"  # Specify the correct AMI ID
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  #user_data = base64encode(file("${path.module}/scripts/init-script.sh")) # User data script to initialize instances

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "AppInstance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 10
  desired_capacity = 2

  vpc_zone_identifier = aws_subnet.private.*.id

  tag {
    key                 = "Name"
    value               = "AppAutoScalingGroup"
    propagate_at_launch = true
  }
}
