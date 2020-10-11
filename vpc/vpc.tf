resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "IaC-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "IaC-vpc-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"

    tags = {
        Name = "IaC-vpc-private-subnet"
    }
}

resource "aws_internet_gateway" "igw" { 
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "IaC-vpc-igw"
    }
}

# resource "aws_eip" "nat" {
#  vpc   = true

#  lifecycle {
#    create_before_destroy = true
#  }
#}

#resource "aws_nat_gateway" "nat_gateway" {
#  allocation_id = aws_eip.nat.id

#  subnet_id = aws_subnet.public_subnet.id

#  tags = {
#    Name = "NAT-GW"
#  }
#}

# Public RT 
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    # 라우트테이블 내에 넣는것cidr_block 전체 공개설정으로  인터넷 게이트웨이로 아웃바운드 된다는 의미
    # inner rule
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "My-RT-Public"
    }
}

# Private RT 
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "My-RT-Private"
    }
}


resource "aws_route_table_association" "route_table_public" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public.id
}

#resource "aws_route_table_association" "route_table_private" {
# subnet_id      = aws_subnet.private_subnet.id
#  route_table_id = aws_route_table.private.id
#}
