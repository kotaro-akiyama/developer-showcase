variable "aws_region" {
  description = "デプロイ対象の AWS リージョン。"
  type        = string
}

variable "aws_account_id" {
  description = "対象 AWS アカウント ID。"
  type        = string
}

variable "site_bucket_name" {
  description = "静的サイトをホスティングする S3 バケット名。"
  type        = string
}

variable "artifact_bucket_name" {
  description = "CodePipeline 用アーティファクトバケット名（空文字列の場合は自動生成）。"
  type        = string
}

variable "github_owner" {
  description = "GitHub リポジトリの所有者（ユーザーまたは組織）。"
  type        = string
}

variable "github_repo" {
  description = "GitHub リポジトリ名。"
  type        = string
}

variable "github_branch" {
  description = "CodePipeline のトリガー対象ブランチ。"
  type        = string
}

variable "connection_arn" {
  description = "CodeStar Connections の ARN。"
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFront の配信価格クラス。"
  type        = string
}

variable "cloudfront_waf_acl_arn" {
  description = "CloudFront ディストリビューションに関連付ける WAFv2 ACL の ARN（未使用の場合は空文字列）。"
  type        = string
}
