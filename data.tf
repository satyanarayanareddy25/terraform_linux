data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  # Filter for a specific type of AMI, such as Amazon Linux 2
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Modify the name pattern as needed
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

