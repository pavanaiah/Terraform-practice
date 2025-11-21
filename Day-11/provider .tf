terraform {
    backend  "s3"{
        bucket = "pavan-bucket1506"
        region = "ap-south-1"
        key = "project/demo.statefile"
        use_lockfile = true
    }
}

provider "aws" {
    region = "ap-south-1"
  
}