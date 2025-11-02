data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = substr("${var.codebuild_project_name}-role", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codebuild_permissions" {
  statement {
    sid     = "SiteBucketList"
    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.site.arn
    ]
  }

  statement {
    sid = "SiteBucketObjects"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.site.arn}/*"
    ]
  }

  statement {
    sid = "ArtifactBucket"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.artifact.arn,
      "${aws_s3_bucket.artifact.arn}/*"
    ]
  }

  statement {
    sid       = "CloudFrontInvalidation"
    actions   = ["cloudfront:CreateInvalidation"]
    resources = ["*"]
  }

  statement {
    sid = "Logging"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      aws_cloudwatch_log_group.codebuild.arn,
      "${aws_cloudwatch_log_group.codebuild.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "codebuild-inline"
  role   = aws_iam_role.codebuild.id
  policy = data.aws_iam_policy_document.codebuild_permissions.json
}

data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline" {
  name               = substr("${var.pipeline_name}-role", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codepipeline_permissions" {
  statement {
    sid = "ArtifactBucket"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.artifact.arn,
      "${aws_s3_bucket.artifact.arn}/*"
    ]
  }

  statement {
    sid = "CodeBuild"

    actions = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds"
    ]

    resources = [
      aws_codebuild_project.static_site.arn
    ]
  }

  statement {
    sid = "PassRole"

    actions = ["iam:PassRole"]

    resources = [
      aws_iam_role.codebuild.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    sid       = "UseCodeStarConnection"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.connection_arn]
  }
}

resource "aws_iam_role_policy" "codepipeline" {
  name   = "codepipeline-inline"
  role   = aws_iam_role.codepipeline.id
  policy = data.aws_iam_policy_document.codepipeline_permissions.json
}
