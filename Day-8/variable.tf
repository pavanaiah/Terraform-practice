variable "resource_values" {
    type = object({
      vpc_cidr = string
      vpc_name = string 
      
      subnet_info = object({
        sub_cidr = list(string)
        sub_az = list(string)
        sub_name = list(string)
      })

      rt_name = string
      rt_cidr = string
      igw_name = string

      sg = object({
        name = string 
        desc = string
        ingress_22 = object({
          from_port = number
          protocol = string 
          ing_cidr = list(string)
        })
        ingress_80 = object({
          from_port = number
          protocol = string 
          ing_cidr = list(string)
        })
        egress = object({
        port_no = number 
        protocol = string
        eg_cidr = list(string)
        })
      })

      instance = object({
        instance_type = string
        key_name = string
        inst_name = string
      })
      
    })

    default = {
      vpc_cidr = "10.0.0.0/16"
      vpc_name = "my-vpc"
      subnet_info = {
        sub_az = [ "ap-south-1a","ap-south-1b" ]
        sub_cidr =["10.0.0.0/24","10.0.1.0/24"]
        sub_name =["sub-1","sub-2"]
      }

      rt_name = "my-rt"
      rt_cidr = "0.0.0.0/0"
      igw_name = "my-igw"

      sg = {
        name = "my-sg"
        desc ="allow ssh and http"
        ingress_22 = {
          from_port = 22
          protocol = "tcp"
          ing_cidr = ["0.0.0.0/0"]

        }
        ingress_80 = {
          from_port = 80
          protocol = "tcp"
          ing_cidr = ["0.0.0.0/0"]
        }
        egress = {
           port_no = 0
           protocol = "-1"
           eg_cidr = ["0.0.0.0/0"]
        }
      }
      instance ={
        instance_type = "t3.micro"
        key_name = "test"
        inst_name = "ubuntu"
      }
        

    }
  
}

 