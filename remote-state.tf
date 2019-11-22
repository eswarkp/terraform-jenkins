terraform {
  backend "s3" {
    bucket = "eswarkp-state-bucket2"
    key    = "week3"
    region = "ap-south-1"
  }
}
