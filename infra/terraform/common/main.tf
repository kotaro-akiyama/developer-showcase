locals {
  project     = var.project
  environment = var.environment

  default_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile != "" ? var.aws_profile : null

  default_tags {
    tags = local.default_tags
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Add additional modules and resources here, using the shared tagging and provider configuration above.
