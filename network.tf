resource "aws_vpc" "minecraft" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "minecraft"
    }
}

resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.minecraft.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"

    depends_on = [
      aws_vpc.minecraft
    ]

    tags = {
        Name = "public-1"
    }
}

resource "aws_subnet" "public-2" {
    vpc_id = aws_vpc.minecraft.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-1c"

    depends_on = [
      aws_vpc.minecraft
    ]

    tags = {
        Name = "public-2"
    }
}
  
resource "aws_subnet" "private-1" {
    vpc_id = aws_vpc.minecraft.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-1a"

    depends_on = [
      aws_vpc.minecraft
    ]

    tags = {
        Name = "private-1"
    }
}

resource "aws_subnet" "private-2" {
    vpc_id = aws_vpc.minecraft.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "ap-northeast-1c"

    depends_on = [
        aws_vpc.minecraft
    ]

    tags = {
        Name = "private-2"
    }
}

resource "aws_internet_gateway" "minecraft" {
    vpc_id = aws_vpc.minecraft.id

    depends_on = [
        aws_vpc.minecraft
    ]

    tags = {
        Name = "minecraft"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.minecraft.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.minecraft.id
    }

    depends_on = [
      aws_vpc.minecraft
    ]

    tags = {
        Name = "public"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.minecraft.id

    depends_on = [
      aws_vpc.minecraft
    ]

    tags = {
        Name = "private"
    }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft.id

    depends_on = [
        aws_internet_gateway.minecraft,
        aws_route_table.public
    ]
}

resource "aws_route_table_association" "public-1" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.public.id

    depends_on = [
      aws_subnet.public-1,
        aws_route_table.public
    ]
}

resource "aws_route_table_association" "public-2" {
    subnet_id = aws_subnet.public-2.id
    route_table_id = aws_route_table.public.id

    depends_on = [
        aws_subnet.public-2,
        aws_route_table.public
    ]
}

resource "aws_route_table_association" "private-1" {
    subnet_id = aws_subnet.private-1.id
    route_table_id = aws_route_table.private.id

    depends_on = [
        aws_subnet.private-1,
        aws_route_table.private
    ]
}

resource "aws_route_table_association" "private-2" {
    subnet_id = aws_subnet.private-2.id
    route_table_id = aws_route_table.private.id

    depends_on = [
        aws_subnet.private-2,
        aws_route_table.private
    ]
}

