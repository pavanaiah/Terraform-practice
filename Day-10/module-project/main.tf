module "moduleproject" {

  source = "D:/PRACTICE/Terraform-practice/doneclasses/New folder/project-1"

  resource_values ={
  region = "us-east-1"
  vpc_name = "p1-vpc"
  vpc_cidr = "10.0.0.0/16"
  subnet_info = {
    sub_az = [ "us-east-1a","us-east-1b" ]
    sub_cidr = ["10.0.1.0/24","10.0.2.0/24"]
    sub_name = ["p2-sub-1", "p2-sub-2"]
}

}

}
  