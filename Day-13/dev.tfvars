     resource_values = {
        vpc-cidr = "20.0.0.0/16"
        vpc-name = "dev-vpc"
        subnet-info = {
        sub-az = [ "ap-south-1a","ap-south-1b" ]
        sub-cidr =["20.0.4.0/24","20.0.8.0/24"]
        sub-name =["dev-sub-1","dev-sub-2"]
      }

        rt-name = "my-rt"
        rt-cidr = "0.0.0.0/0"
        igw-name = "my-igw"

        sg = {
        name = "my-sg"
        desc ="allow ssh and http"
        ingress_22 = {
          from-port = 22
          protocol = "tcp"
          ing-cidr = ["0.0.0.0/0"]

        }
        ingress_80 = {
          from-port = 80
          protocol = "tcp"
          ing-cidr = ["0.0.0.0/0"]
        }
        egress = {
           port-no = 0
           protocol = "-1"
           eg-cidr = ["0.0.0.0/0"]
        }
      }
      instance ={
        instance-type = "t3.micro"
        key-name = "pavan-key"
        inst-name = "ubuntu"
      }
     }