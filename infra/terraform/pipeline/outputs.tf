output "site_bucket_name" {
  description = "静的サイト配信用 S3 バケット名。"
  value       = module.static_site_pipeline.site_bucket_name
}

output "artifact_bucket_name" {
  description = "CodePipeline アーティファクト用 S3 バケット名。"
  value       = module.static_site_pipeline.artifact_bucket_name
}

output "cloudfront_distribution_domain" {
  description = "CloudFront ディストリビューションのドメイン。"
  value       = module.static_site_pipeline.cloudfront_distribution_domain
}

output "cloudfront_distribution_id" {
  description = "CloudFront ディストリビューション ID。"
  value       = module.static_site_pipeline.cloudfront_distribution_id
}

output "codepipeline_name" {
  description = "作成された CodePipeline 名。"
  value       = module.static_site_pipeline.codepipeline_name
}

output "cloudfront_logs_bucket_name" {
  description = "CloudFront アクセスログ保存用 S3 バケット名。"
  value       = module.static_site_pipeline.cloudfront_logs_bucket_name
}
