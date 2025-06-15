terraform {
  backend "s3" {
    bucket = "kshitijhatwar-bucket"
    key = "terraform/backend"
    region = "ap-south-1"
  }
}
