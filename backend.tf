terraform {
  backend "s3" {
    bucket = "test-monday-yanam"
    key    = "terraformfiles/terraform.tfstate"
    region = "us-east-1"
  }
}
