variable "aws_region" {
  description = "AWS リージョン。"
  type        = string
}

variable "aws_account_id" {
  description = "AWS アカウント ID。"
  type        = string
}

variable "site_bucket_name" {
  description = "静的サイト配信用 S3 バケット名。"
  type        = string
}

variable "artifact_bucket_name" {
  description = "CodePipeline 用アーティファクトバケット名。"
  type        = string
}

variable "repository_id" {
  description = "GitHub リポジトリ ID (owner/repo)。"
  type        = string
}

variable "github_branch" {
  description = "CodePipeline のトリガー対象ブランチ。"
  type        = string
}

variable "pipeline_name" {
  description = "CodePipeline の名前。"
  type        = string
}

variable "cloudfront_logs_bucket_name" {
  description = "CloudFront アクセスログ保存用 S3 バケット名。"
  type        = string
}

variable "codebuild_project_name" {
  description = "CodeBuild プロジェクト名。"
  type        = string
}

variable "oac_name" {
  description = "CloudFront OAC 名。"
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFront の価格クラス。"
  type        = string
}

variable "connection_arn" {
  description = "CodeStar Connections の ARN。"
  type        = string
}

variable "cloudfront_waf_acl_arn" {
  description = "CloudFront ディストリビューションに関連付ける WAFv2 ACL の ARN。空文字列の場合は関連付けなし。"
  type        = string
}

variable "tags" {
  description = "全リソースに付与するタグ。"
  type        = map(string)
}
