terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
