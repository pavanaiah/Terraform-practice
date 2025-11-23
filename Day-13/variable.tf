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

  
}

 