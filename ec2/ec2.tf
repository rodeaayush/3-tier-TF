
resource "aws_instance" "vm-nginx" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = "ubuntukey"

    tags = {
        Name = "Nginx-Instance"
    }
    user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum update -y
    yum install nginx -y
    systemctl start nginx
    systemctl enable nginx
    EOF

}


resource "aws_instance" "vm-db" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private-db.id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = "ubuntukey"

    tags = {
        Name = "Database-Instance"
    }
}

resource "aws_instance" "vm-tom" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private-tom.id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = "ubuntukey"

    tags = {
        Name = "Tomcat-Instance"
    }
}


resource "aws_security_group" "demo-sg" {
    name = "three-tier-sg"
    description = "allow ports ssh db tomcat and http to instance"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

      ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "three-tier-sg"
    }
}
