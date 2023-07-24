#Note: the first configuration commented is outdated and doesn't work
# Create S3 Bucket Resource
/* resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  #acl    = "public-read" default is "private"  
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


# Template to Create S3 Bucket Resource With public-read ACL (ALLOW PUBLIC ACCESS/block all public access box unchecked)
# TEMPLATE to Create an s3 bucket With just public-read ACL (ALLOW PUBLIC ACCESS)
/*resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name #"atto-s3-bucket1"
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





# TEMPLATE to Create an s3 bucket With public-read ACL (ALLOW PUBLIC ACCESS/block all public access box unchecked),
# website hosting enabled, and public read ACL enabled (in this case  won't be automated by terraform but added in the management console)
resource "aws_s3_bucket" "s3_bucket" {
  #bucket = "atto-s3-bucket1"
  bucket        = var.bucket_name
  force_destroy = true

  #policy = file("policy1.json") #add the policy directly on the website in the s3 bucket permission ==>> bucket policy
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

# inline policy
resource "aws_iam_policy" "s3_policy" {
  name        = "s3_public_policy"
  path        = "/"
  description = "s3 public policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject",
        Action = [
          "s3:GetObject",
          #"s3:ListBucket",
        ]
        Effect = "Allow"
        #Principal = "*",
        Resource = "${aws_s3_bucket.s3_bucket.arn}/*", #aws_s3_bucket.s3_bucket.arn #"*"
      },
    ]
  })
}







# TEMPLATE to Create an s3 bucket With private ACL (BLOCK PUBLIC ACCESS)
/* resource "aws_s3_bucket" "s3_bucket_private" {
  bucket = var.bucket_name #"atto-s3-bucket4"
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
} */


# Template for the public read access policy (for the website(s3endpoint) to display)
/* {
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
              "arn:aws:s3:::atto-s3-bucket1/*" # or replace atto-s3-bucket1 with ${var.bucket_name} if using variables
          ]
      }
  ]
} */
