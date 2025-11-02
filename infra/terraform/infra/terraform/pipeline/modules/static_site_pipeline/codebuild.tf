resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/aws/codebuild/${var.codebuild_project_name}"
  retention_in_days = 30
  tags              = var.tags
}

resource "aws_codebuild_project" "static_site" {
  name         = var.codebuild_project_name
  description  = "Build static site and deploy to ${aws_s3_bucket.site.bucket}"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SITE_BUCKET_NAME"
      value = aws_s3_bucket.site.bucket
    }

    environment_variable {
      name  = "CLOUDFRONT_DISTRIBUTION_ID"
      value = aws_cloudfront_distribution.site.id
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = "build"
    }
  }

  tags = var.tags
}
