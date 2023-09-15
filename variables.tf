variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "s3_bucket_name" {
  type    = string
  default = "devops-bootcamp-2023-use-case-1-bucket"
}


variable "key_name" {
  type        = string
  description = "Name of the key"
  default     = "bootcamp-key"
}