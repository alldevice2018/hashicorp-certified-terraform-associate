# Call our Custom Terraform Module which we built earlier
module "website_s3_bucket" {
  source  = "app.terraform.io/harsh-certified-terraf-associate_demo1/s3website/aws"
  version = "1.0.1"
  # insert required variables here
  bucket_name = var.my_s3_bucket
}

