resource "aws_vpc" "mydefaultvpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpcteste"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.mydefaultvpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public"
  }
}


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.mydefaultvpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mydefaultvpc.id

  tags = {
    name = "vpc-igw"
  }

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mydefaultvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id

}
