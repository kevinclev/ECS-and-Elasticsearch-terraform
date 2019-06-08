resource "aws_security_group" "internal" {
  name        = "webapp-internal"
  description = "internal rules"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    self       = true
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    self       = true
  }
}

resource "aws_security_group" "external" {
  name        = "webapp-external"
  description = "external rules"
  vpc_id      = "${var.vpc_id}"

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
