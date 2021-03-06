variable "region" {
  default = "ap-southeast-2"
}

variable "profile" {
  description = "aws profile to use"
  default     = "psn"
}

variable "bucket_name" {
  description = "The name of the S3 bucket. Must be unique globally."
  default     = "corp-maven-repo"
}
