data "local_file" "pubkey" {
  filename = pathexpand("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "key" {
  key_name   = format("%s-key", var.prefix)
  public_key = data.local_file.pubkey.content
}

resource "aws_security_group" "sg-ingress-server" {
  name = "ingress-server"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "server" {
  ami                    = "ami-0eb11ab33f229b26c"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg-ingress-server.id]
  tags = {
    Name = "server"
  }
}
