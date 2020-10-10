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