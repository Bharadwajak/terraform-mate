variable "region" {
  default = "ap-southeast-2"
}

variable "profile" {
  description = "aws profile to use"
  default     = "psn"
}

variable "key_name" {
  description = "key name to connect to ec2"
  default     = "id-psn-ap-southeast-2"
}
