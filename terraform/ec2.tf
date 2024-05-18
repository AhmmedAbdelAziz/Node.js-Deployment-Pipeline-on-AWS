# Create two EC2 instances
resource "aws_instance" "app_server_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]


  tags = {
    Name = "AppServer1"
  }
}

resource "aws_instance" "app_server_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name
  subnet_id     = aws_subnet.public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]


  tags = {
    Name = "AppServer2"
  }
}

# Attach the EC2 instances to the target group
resource "aws_lb_target_group_attachment" "tg_attachment_1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.app_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.app_server_2.id
  port             = 80
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Create an Elastic IP for AppServer1
resource "aws_eip" "app_server_1" {
  vpc      = true
  instance = aws_instance.app_server_1.id

  tags = {
    Name = "AppServerEIP1"
  }
}

# Create an Elastic for AppServer2
resource "aws_eip" "app_server_2" {
  vpc      = true
  instance = aws_instance.app_server_2.id

  tags = {
    Name = "AppServerEIP2"
  }
}
