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

    default = {
      vpc-cidr = "10.0.0.0/16"
      vpc-name = "my-first-vpc"
      subnet-info = {
        sub-az = ["ap-south-1a","ap-south-1b"]
        sub-cidr = ["10.0.0.0/24","10.0.1.0/24"]
        sub-name = ["sub-1","sub-2"]
      }
    }
  
}