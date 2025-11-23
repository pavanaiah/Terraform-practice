resource "aws_vpc" "r_vpc" {
    cidr_block = var.resource_values.vpc-cidr

    tags = {
      Name = var.resource_values.vpc-name
    }
  
}


resource "aws_subnet" "r_sub" {
    vpc_id = aws_vpc.r_vpc.id

    count = length(var.resource_values.subnet-info.sub-cidr)

    cidr_block =var.resource_values.subnet-info.sub-cidr[count.index]
    availability_zone = var.resource_values.subnet-info.sub-az[count.index]

    tags = {
        Name =var.resource_values.subnet-info.sub-name[count.index]
    }

}   


resource "aws_route_table" "r-rt" {
    vpc_id = aws_vpc.r_vpc.id

    tags = {
      Name = var.resource_values.rt-name
    }

   route {
    cidr_block = var.resource_values.rt-cidr
    gateway_id = aws_internet_gateway.r_igw.id

}
}


resource "aws_internet_gateway" "r_igw" {
    vpc_id = aws_vpc.r_vpc.id

    tags = {
      Name = var.resource_values.igw-name
    }

}

resource "aws_route_table_association" "r_sa" {
    subnet_id = aws_subnet.r_sub[0].id
    route_table_id = aws_route_table.r-rt.id
  
}

resource "aws_security_group" "r_sg" {
    vpc_id = aws_vpc.r_vpc.id
    name =var.resource_values.sg.name
    description = var.resource_values.sg.desc  

    ingress {
        to_port = var.resource_values.sg.ingress_22.from-port
        from_port = var.resource_values.sg.ingress_22.from-port
        protocol = var.resource_values.sg.ingress_22.protocol
        cidr_blocks = var.resource_values.sg.ingress_22.ing-cidr
    }

    ingress {
        to_port = var.resource_values.sg.ingress_80.from-port
        from_port = var.resource_values.sg.ingress_80.from-port
        protocol = var.resource_values.sg.ingress_80.protocol
        cidr_blocks = var.resource_values.sg.ingress_80.ing-cidr
    }

    egress {
        to_port = var.resource_values.sg.egress.port-no  
        from_port = var.resource_values.sg.egress.port-no
        protocol = var.resource_values.sg.egress.protocol
        cidr_blocks =var.resource_values.sg.egress.eg-cidr
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

resource "aws_instance" "r_ec2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.resource_values.instance.instance-type
    key_name = var.resource_values.instance.key-name
    vpc_security_group_ids = [aws_security_group.r_sg.id]
    subnet_id = aws_subnet.r_sub[0].id
    associate_public_ip_address = true

    tags = {
      Name = var.resource_values.instance.inst-name
}
}

resource "null_resource" "ser_commands" {
    triggers = {
      build =1.0
    }

    connection {
      type = "ssh"
      private_key = file("C:/Users/pavan/Downloads/pavan-key.pem")
      user = "ubuntu"
      host = aws_instance.r_ec2.public_ip
    }

    provisioner "remote-exec" {

        inline = [ "sudo apt update ",
                   "sudo apt install unzip nginx -y" ,
                   "wget  https://templatemo.com/tm-zip-files-2020/templatemo_596_electric_xtra.zip ",
                   " unzip templatemo_596_electric_xtra.zip",
                   " sudo mv templatemo_596_electric_xtra  /var/www/html"

                    ]          
      
    }
  
}