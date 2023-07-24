# Output variable definitions

output "arn" {
  description = "ARN of the S3 Bucket"
  value       = aws_s3_bucket.s3_bucket.arn
  #value = aws_s3_bucket.s3_bucket_private.website_endpoint
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
  #value = aws_s3_bucket.s3_bucket_private.website_endpoint
}

output "domain" {
  description = "Domain Name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_domain
  #value = aws_s3_bucket.s3_bucket_private.website_domain
}

output "endpoint" {
  description = "Endpoint Information of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_endpoint
  #value = aws_s3_bucket.s3_bucket_private.website_endpoint
}
