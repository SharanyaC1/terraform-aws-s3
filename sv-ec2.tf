resource "aws_instance" "web" {
  ami           = "ami-0f559c3642608c138"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[0].id
 associate_public_ip_address = true
 vpc_security_group_ids = [aws_security_group.web_sg.id]
 key_name = "mrin-key"
 user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              EOF
  tags = {
    Name = "web-server"
  }
}