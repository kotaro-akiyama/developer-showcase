resource "aws_cloudfront_origin_access_control" "site" {
  name                              = var.oac_name
  description                       = "OAC for ${aws_s3_bucket.site.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  comment             = var.repository_id
  default_root_object = "index.html"
  price_class         = var.cloudfront_price_class
  web_acl_id          = length(trim(var.cloudfront_waf_acl_arn)) > 0 ? var.cloudfront_waf_acl_arn : null

  origin {
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id                = "site-bucket"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = "site-bucket"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  logging_config {
    bucket = "${aws_s3_bucket.cloudfront_logs.bucket}.s3.amazonaws.com"
    prefix = "cloudfront/"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(var.tags, { Service = "cloudfront" })
}

data "aws_iam_policy_document" "site_bucket" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.site.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.site.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site_bucket.json

  depends_on = [
    aws_cloudfront_distribution.site
  ]
}

data "aws_iam_policy_document" "cloudfront_logs" {
  statement {
    sid     = "AllowCloudFrontDelivery"
    actions = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.cloudfront_logs.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [var.aws_account_id]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.site.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_logs" {
  bucket = aws_s3_bucket.cloudfront_logs.id
  policy = data.aws_iam_policy_document.cloudfront_logs.json
}
