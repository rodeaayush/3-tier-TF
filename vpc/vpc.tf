resource  "aws_vpc" "vnet" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "vpc-three-tier"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet"
    }
}

resource "aws_subnet" "private-tom" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet-Tomcat"
    }
}


resource "aws_subnet" "private-db" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "ap-south-1c"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet-Database"
    }
}

resource "aws_internet_gateway" "igw-demo" {

    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "igw-three-tier"
    }
}

resource "aws_route_table" "RT-public" {
    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "RT-public"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-demo.id
    }
}

resource "aws_route_table" "RT-private" {
    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "RT-private"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-vpc-tf.id
}
}

resource "aws_eip" "eip" {
 domain = "vpc"
}


resource "aws_nat_gateway" "nat-vpc-tf" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public.id
}
resource "aws_route_table_association" "rt-public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.RT-public.id
}

resource "aws_route_table_association" "rt-private" {
    subnet_id = aws_subnet.private-tom.id
    route_table_id = aws_route_table.RT-private.id
}
resource "aws_route_table_association" "rt-private-db" {
    subnet_id = aws_subnet.private-db.id
    route_table_id = aws_route_table.RT-private.id
}
