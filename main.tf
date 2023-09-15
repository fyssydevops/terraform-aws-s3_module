resource "aws_s3_bucket" "bootcamp_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "Bootcamp Use Case 1 bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bootcamp_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket     = aws_s3_bucket.bootcamp_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bootcamp_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_ecryption" {
  bucket = aws_s3_bucket.bootcamp_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_kms_key" "key" {
  description         = var.key_name
  enable_key_rotation = true
}

resource "aws_kms_alias" "kms_key_alias" {
  name          = "alias/${var.key_name}"
  target_key_id = aws_kms_key.key.key_id
}