# main.tf

provider "aws" {
  region = "us-east-1" # Replace with your preferred region
}

# Launch Template
resource "aws_launch_template" "autoscalling" {
  name_prefix          = "example-"
  image_id             = "ami-005fc0f236362e99f" # Replace with your AMI ID
  instance_type        = "t2.micro"
  key_name             = "awsmachine" # Replace with your SSH key

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["sg-0064424eca7f75a92"] # Replace with your security group
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.autoscalling.id
    version = "$Latest"
  }

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = ["subnet-055a8b61471358e15"] # Replace with your subnet ID

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}
