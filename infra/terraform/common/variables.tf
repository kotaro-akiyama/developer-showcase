variable "project" {
  description = "タグ付けや命名で使用するプロジェクト識別子。"
  type        = string
}

variable "environment" {
  description = "デプロイ対象の環境名（例: dev, stg, prod）。"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "リソースをデプロイする AWS リージョン。"
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "認証に使用する AWS CLI プロファイル名。未指定の場合はデフォルトの認証情報チェーンを利用。"
  type        = string
  default     = ""
}

variable "notification_emails" {
  description = "AWS Budgets アラートを受信するメールアドレス一覧。"
  type        = list(string)
  validation {
    condition     = length(var.notification_emails) > 0
    error_message = "notification_emails must include at least one email address."
  }
}

variable "budget_limit" {
  description = "AWS Budgets アラートを発火させる絶対支出額の閾値。"
  type        = number
  default     = 100
}

variable "time_unit" {
  description = "AWS Budget で集計する期間単位。"
  type        = string
  default     = "MONTHLY"
  validation {
    condition     = contains(["DAILY", "MONTHLY", "QUARTERLY", "ANNUALLY"], upper(var.time_unit))
    error_message = "time_unit must be one of DAILY, MONTHLY, QUARTERLY, or ANNUALLY."
  }
}

variable "currency" {
  description = "AWS Budgets で利用する通貨コード。"
  type        = string
  default     = "USD"
  validation {
    condition     = length(var.currency) == 3
    error_message = "currency must be a three-letter ISO 4217 code such as USD."
  }
}
