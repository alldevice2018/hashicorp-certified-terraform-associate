# Create S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket        = "state-import-bucket"
  acl           = "private"
  force_destroy = false
}
# terraform import aws_s3_bucket.mybucket state-import-bucket


# TEMPLATE to Create an s3 bucket With public-read ACL (ALLOW PUBLIC ACCESS)
/*resource "aws_s3_bucket" "s3_bucket" {
  bucket = "atto-s3-bucket1"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_bucket,
    aws_s3_bucket_public_access_block.s3_bucket,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}
*/

# TEMPLATE to Create an s3 bucket With private ACL (BLOCK PUBLIC ACCESS)
/*resource "aws_s3_bucket" "s3_bucket_private" {
  bucket = "atto-s3-bucket2"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_private" {
  bucket = aws_s3_bucket.s3_bucket_private.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_private" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_private]

  bucket = aws_s3_bucket.s3_bucket_private.id
  acl    = "private"
}
*/

