# Generate a random id of 6 length
resource "random_id" "bucket_suffix" {
  byte_length = "6"
}

# Create a S3 bucket
resource "aws_s3_bucket" "my_test_bucket" {
  bucket = "my_test_bucket-${random_id.bucket_suffix.hex}"
}

# Get the name of s3 bucket on the output
output "bucket_name" {
  value = aws_s3_bucket.my_test_bucket.bucket
}