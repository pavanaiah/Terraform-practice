variable "resource_values" {
    type = object({
      vpc-cidr = string
      vpc-name = string 
      
      subnet-info = object({
        sub-cidr = list(string)
        sub-az = list(string)
        sub-name = list(string)
      })

      rt-name = string
      rt-cidr = string
      igw-name = string

      sg = object({
        name = string 
        desc = string
        ingress_22 = object({
          from-port = number
          protocol = string 
          ing-cidr = list(string)
        })
        ingress_80 = object({
          from-port = number
          protocol = string 
          ing-cidr = list(string)
        })
        egress = object({
        port-no = number 
        protocol = string
        eg-cidr = list(string)
        })
      })

      instance = object({
        instance-type = string
        key-name = string
        inst-name = string
      })
      
    })

    default = {
      vpc-cidr = "10.0.0.0/16"
      vpc-name = "my-vpc"
      subnet-info = {
        sub-az = [ "ap-south-1a","ap-south-1b" ]
        sub-cidr =["10.0.0.0/24","10.0.1.0/24"]
        sub-name =["sub-1","sub-2"]
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
        key-name = "test"
        inst-name = "ubuntu"
      }
        

    }
  
}

 