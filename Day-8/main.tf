resource "aws_vpc" "vpc-v1" {
    cidr_block = var.resource_values.vpc_cidr

    tags = {
      Name = var.resource_values.vpc_name
    }
  
}


resource "aws_subnet" "sub_v" {
    vpc_id = aws_vpc.vpc-v1.id

    count = length(var.resource_values.subnet_info.sub_cidr)

    cidr_block =var.resource_values.subnet_info.sub_cidr[count.index]
    availability_zone = var.resource_values.subnet_info.sub_az[count.index]

    tags = {
        Name =var.resource_values.subnet_info.sub_name[count.index]
    }

}   


resource "aws_route_table" "r-v" {
    vpc_id = aws_vpc.vpc-v1.id

    tags = {
      Name = var.resource_values.rt_name
    }

   route {
    cidr_block = var.resource_values.rt_cidr
    gateway_id = aws_internet_gateway.igw-v.id

}
}


resource "aws_internet_gateway" "igw-v" {
    vpc_id = aws_vpc.vpc-v1.id

    tags = {
      Name = var.resource_values.igw_name
    }

}

resource "aws_route_table_association" "rta-v" {
    subnet_id = aws_subnet.sub_v[0].id
    route_table_id = aws_route_table.r-v.id
  
}

resource "aws_security_group" "seg-v" {
    vpc_id = aws_vpc.vpc-v1.id
    name =var.resource_values.sg.name
    description = var.resource_values.sg.desc  

    ingress {
        to_port = var.resource_values.sg.ingress_22.from_port
        from_port = var.resource_values.sg.ingress_22.from_port
        protocol = var.resource_values.sg.ingress_22.protocol
        cidr_blocks = var.resource_values.sg.ingress_22.ing_cidr
    }

    ingress {
        to_port = var.resource_values.sg.ingress_80.from_port
        from_port = var.resource_values.sg.ingress_80.from_port
        protocol = var.resource_values.sg.ingress_80.protocol
        cidr_blocks = var.resource_values.sg.ingress_80.ing_cidr
    }

    egress {
        to_port = var.resource_values.sg.egress.port_no  
        from_port = var.resource_values.sg.egress.port_no
        protocol = var.resource_values.sg.egress.protocol
        cidr_blocks =var.resource_values.sg.egress.eg_cidr
    }
}
data "aws_ami" "ubuntu" {
    
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20251022"]
    }
  
}

resource "aws_instance" "ec2_v" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.resource_values.instance.instance_type
    key_name = var.resource_values.instance.key_name
    vpc_security_group_ids = [aws_security_group.seg-v.id]
    subnet_id = aws_subnet.sub_v[0].id
    associate_public_ip_address = true

    tags = {
      Name = var.resource_values.instance.inst_name
}
}
