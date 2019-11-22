
terraform {
  
  backend "s3" {
    bucket = "redteam-state"
    key    = "redteam"
    region = "ap-south-1"
  }
}
