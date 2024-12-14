variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "name_prefix" {
  description = "Name prefix for application"
  type        = string
  default     = "jason-ce8-coaching-9-s3"
}
