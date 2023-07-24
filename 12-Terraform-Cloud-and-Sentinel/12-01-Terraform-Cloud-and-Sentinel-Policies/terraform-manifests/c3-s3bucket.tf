# Create S3 Bucket Resource
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


# TEMPLATE TO CREATE S3 BUCKET POLICY AND ADD IT TO THE BUCKET by automating with terraform
resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = jsonencode({ #<<POLICY

    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : "arn:aws:s3:::${var.bucket_name}/*",

      }
    ]
  })
  #POLICY
  #depends_on = [aws_s3_bucket.s3_bucket, aws_s3_bucket_acl.s3_bucket, aws_s3_bucket_object.bucket, aws_s3_bucket_ownership_controls.s3_bucket, aws_s3_bucket_public_access_block.s3_bucket]
  depends_on = [
    aws_s3_bucket.s3_bucket,
    aws_s3_bucket_acl.s3_bucket,
    aws_s3_bucket_object.bucket,
    aws_s3_bucket_ownership_controls.s3_bucket,
    aws_s3_bucket_public_access_block.s3_bucket,
  ]

}

# TEMPLATE TO Put index.html in S3 Bucket(STATIC FILE), automating static file into an s3 bucket
#THIS IS GOING TO UPLOAD THE CONTENT OF THE STATIC FILE(INSIDE THE INDEX.HTML) INTO THE S3 BUCKET
resource "aws_s3_bucket_object" "bucket" {
  #acl          = "public-read"#
  key          = "index.html"
  bucket       = aws_s3_bucket.s3_bucket.id
  content      = file("${path.module}/static-files/index.html")
  content_type = "text/html"
}


# TEMPLATE TO CREATE S3 BUCKET POLICY AND ADD IT TO THE BUCKET PERMISSION FROM THE MANAGEMENT CONSOLE
# in this case inline s3 bucket policy is not automated into the bucket but created separately in iam ==>> role==>>s3
/* resource "aws_iam_policy" "s3_policy" {
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
        Effect    = "Allow"
        #Principal = "*",
        Resource  = "${aws_s3_bucket.s3_bucket.arn}/*", #aws_s3_bucket.s3_bucket.arn #"*"
      },
    ]
  })
} */
