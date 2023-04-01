resource "aws_vpc" "my_vpc" {
    cidr_block              = var.cidr_block
    enable_dns_support      = true
    enable_dns_hostnames    = true

    tags = {
        "Name"              = "my-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id                  =   aws_vpc.my_vpc.id
}
####   Private Routes ####
resource "aws_route_table" "private" {
    count                   = length(var.private_subnet_cidr_blocks) // make as many route tables as there are ips in this var.
    vpc_id                  = aws_vpc.my_vpc.id
}

resource "aws_route" "private" {
    count                   = length(var.private_subnet_cidr_blocks)
    route_table_id          = aws_route_table.private[count.index].id //count.index - works as a for loop for multiple rt's
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = aws_nat_gateway.default[count.index].id // onle 1 for now 
}

#### Public Routes ####
resource "aws_route_table" "public" {
    #count                   = length(var.public_subnet_cidr_blocks)
    vpc_id                  = aws_vpc.my_vpc.id
}

resource "aws_route" "public" {
    route_table_id          = aws_route_table.public.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.default.id
}

#### Subnet Defination ####
resource "aws_subnet" "private" {
    count                   = length(var.private_subnet_cidr_blocks)

    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.private_subnet_cidr_blocks[count.index] //get the ip's from this var
    availability_zone       = var.availability_zones[count.index]
}

resource "aws_subnet" "public" {
    count                   = length(var.public_subnet_cidr_blocks)
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.public_subnet_cidr_blocks[count.index]
    availability_zone       = var.availability_zones[count.index]

    map_public_ip_on_launch = true
}

#### Route Table Association #### //attach to subnet
resource "aws_route_table_association" "private" {
    count                   = length(var.private_subnet_cidr_blocks)
    subnet_id               = aws_subnet.private[count.index].id
    route_table_id          = aws_route_table.private[count.index].id 
}

resource "aws_route_table_association" "public" {
    count                   = length(var.public_subnet_cidr_blocks)
    subnet_id               = aws_subnet.public[count.index].id
    route_table_id          = aws_route_table.public.id 
}

#### NAT GATEWAY ####

resource "aws_eip" "nat" {
    count                   = length(var.public_subnet_cidr_blocks)
    vpc                     = true
}

resource "aws_nat_gateway" "default" {
    depends_on              = ["aws_internet_gateway.default"]

    count                   = length(var.public_subnet_cidr_blocks)
    allocation_id           = aws_eip.nat[0].id 
    subnet_id               = aws_subnet.public[count.index].id
}


resource "aws_security_group" "default" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc[0].id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_network_interface" "test" {
  subnet_id       = var.public_subnet_cidr_blocks[0].id
  private_ips     = var.ni_private-ip[0]
  security_groups = [aws_security_group.default.id]
}

resource "aws_instance" "default" {

    ami                     = var.ami
    instance_type           = var.instance_type
    network_interface_id    = aws_network_interface.test.id 
    vpc_security_group_ids  = [aws_security_group.default.id]
    key_name                = var.key_name
}