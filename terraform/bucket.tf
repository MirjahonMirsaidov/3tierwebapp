# Create S3 bucket
resource "aws_s3_bucket" "mirjahon-" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}