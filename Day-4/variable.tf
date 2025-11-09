variable "resource_values" {
    type = object({
      vpc-cidr = string
      vpc-name = string

      subnet-info = object({
       sub-az = list(string)
       sub-cidr = list(string)
       sub-name = list(string)
      })
    })

   }