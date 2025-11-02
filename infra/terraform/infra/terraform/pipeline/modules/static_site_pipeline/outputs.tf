output "site_bucket_name" {
  description = "静的サイト配信用 S3 バケット名。"
  value       = aws_s3_bucket.site.bucket
}

output "artifact_bucket_name" {
  description = "CodePipeline アーティファクト用 S3 バケット名。"
  value       = aws_s3_bucket.artifact.bucket
}

output "cloudfront_logs_bucket_name" {
  description = "CloudFront アクセスログ保存用 S3 バケット名。"
  value       = aws_s3_bucket.cloudfront_logs.bucket
}

output "cloudfront_distribution_domain" {
  description = "CloudFront ディストリビューションのドメイン名。"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront ディストリビューション ID。"
  value       = aws_cloudfront_distribution.site.id
}

output "codepipeline_name" {
  description = "作成された CodePipeline 名。"
  value       = aws_codepipeline.static_site.name
}
