# Input variable definitions

variable "bucket_name" {
  description = "Name of the S3 bucket. Must be Unique across AWS"
  default     = "atto-s3-demo10"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket"
  type        = map(string)
  default     = {}
}
