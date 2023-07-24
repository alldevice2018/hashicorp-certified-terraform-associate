/* # Create S3 Bucket Resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}  
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags          = var.tags
  force_destroy = true
} */

resource "aws_s3_bucket" "s3_bucket" {
  #bucket = "atto-s3-bucket1"
  bucket = var.bucket_name
  #policy = file("policy.json") add the policy directly on the website in the s3 bucket permission ==>> bucket policy
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
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
