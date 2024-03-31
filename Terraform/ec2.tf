
// Create an EC2 instance
resource "aws_instance" "alamy_instance" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = "alamykey" 
  security_groups = [aws_security_group.alamy_security_group.name]
  
  // Define tags for the instance
  tags = {
    Name = "alamy-instance"
  }
}

// Create a security group
resource "aws_security_group" "alamy_security_group" {
  name        = "alamy-security-group"
  description = "Allow SSH and HTTP traffic"
  
  // Define ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  
  // Define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}


