variable "project" {
  description = "Project identifier used for tagging and naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment name (e.g. dev, stg, prod)."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "Named AWS CLI profile to use for authentication. Leave empty to use default credentials chain."
  type        = string
  default     = ""
}
