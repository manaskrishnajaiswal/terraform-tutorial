output "static_website_endpoint" {
  value = aws_s3_bucket_website_configuration.s3_bucket_website_configuration.website_endpoint
}