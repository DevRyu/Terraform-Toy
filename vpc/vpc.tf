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
    ## rt-rule-1-method) inner rule 방식으로 적용 한 코드
    #route {
    #    cidr_block = "0.0.0.0/0"
    #    gateway_id = aws_internet_gateway.igw.id
    #}

    tags = {
        Name = "My-RT-Public"
    }
}
## rt-rule-2-method) 외부 리소스로 따로 테라폼 코드로 빼는 코드(적용하진 않음)
#resource "aws_route" "public_igw_1" {
#  route_table_id              = aws_route_table.public.id
#  destination_cidr_block      = "0.0.0.0/0"
#  gateway_id     = aws_internet_gateway.igw.id
#}

resource "aws_route_table_association" "route_table_public" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public.id
}


# Private RT 
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "My-RT-Private"
    }
}

#resource "aws_route" "private_nat_1" {
#  route_table_id              = aws_route_table.private.id
#  destination_cidr_block      = "0.0.0.0/0"
#  nat_gateway_id              = aws_nat_gateway.nat_gateway.id
#}

#resource "aws_route_table_association" "route_table_private" {
# subnet_id      = aws_subnet.private_subnet.id
#  route_table_id = aws_route_table.private.id
#}
#