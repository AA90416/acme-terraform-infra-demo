# modules/vpc/main.tf

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Project = "demo-assignment"
    Name    = "My Demo VPC"
  }
}

resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub1_cidr_block
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Project = "demo-assignment"
    Name    = "public_subnet1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub2_cidr_block
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Project = "demo-assignment"
    Name    = "public_subnet2"
  }
}

resource "aws_subnet" "prv_sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub1_cidr_block
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = false
  tags = {
    Project = "demo-assignment"
    Name    = "private_subnet1"
  }
}

resource "aws_subnet" "prv_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub2_cidr_block
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = false
  tags = {
    Project = "demo-assignment"
    Name    = "private_subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Project = "demo-assignment"
    Name    = "internet gateway"
  }
}

resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "public subnet route table"
  }
}

resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub1.id
}

resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub2.id
}

resource "aws_eip" "eip_natgw1" {
  count = 1
}

resource "aws_nat_gateway" "natgateway_1" {
  allocation_id = aws_eip.eip_natgw1[0].id
  subnet_id     = aws_subnet.pub_sub1.id
}

resource "aws_eip" "eip_natgw2" {
  count = 1
}

resource "aws_nat_gateway" "natgateway_2" {
  allocation_id = aws_eip.eip_natgw2[0].id
  subnet_id     = aws_subnet.pub_sub2.id
}

resource "aws_route_table" "prv_sub1_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_1.id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "private subnet1 route table"
  }
}

resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  route_table_id = aws_route_table.prv_sub1_rt.id
  subnet_id      = aws_subnet.prv_sub1.id
}

resource "aws_route_table" "prv_sub2_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_2.id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "private subnet2 route table"
  }
}

resource "aws_route_table_association" "pri_sub2_to_natgw2" {
  route_table_id = aws_route_table.prv_sub2_rt.id
  subnet_id      = aws_subnet.prv_sub2.id
}

resource "aws_security_group" "elb_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name    = var.sg_tagname
    Project = "demo-assignment"
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = var.sg_ws_name
  description = var.sg_ws_description
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name    = var.sg_ws_tagname
    Project = "demo-assignment"
  }
}
