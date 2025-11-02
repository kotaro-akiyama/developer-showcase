# 開発者ショーケース アーキテクチャ設計

## 1. 全体像
- **アプリ層**: `app/` 配下に静的 HTML / CSS / JavaScript で構成した健康食品サイトを配置する。
- **インフラ層**: Terraform で AWS リソースを管理。共通設定を `infra/terraform/common/` に集約し、プロダクト固有スタックを `infra/terraform/pipeline/` で組み立てる。
- **自動化層**: GitHub main ブランチへの push をトリガーに CodePipeline が実行。CodeBuild が `infra/terraform/pipeline/buildspec.yml` を参照し、`app/` の静的ファイルを S3 へデプロイ後 CloudFront をキャッシュ更新する。

## 2. コンポーネント構成
- `common` レイヤー  
  - AWS Provider とタグの共通設定  
  - Amazon EventBridge のコスト監視（AWS Budgets）  
  - `.tfvars` でメール通知先や閾値を管理
- `pipeline` レイヤー  
  - **S3**: サイト配信用バケット、CodePipeline アーティファクトバケット、CloudFront ログバケット  
  - **CloudFront**: OAC 経由でサイトバケットを公開し、WAF ARN を任意設定  
  - **CodeBuild**: `app/` をコピーして静的アセットを生成し、S3 デプロイ・CloudFront キャッシュ無効化を実行  
  - **CodePipeline**: CodeStar Connections（GitHub）→ CodeBuild → デプロイの 3 ステージ構成  
  - **IAM**: CodeBuild/CodePipeline が必要な S3・CloudFront・CloudWatch へアクセスできるロール・ポリシー

## 3. デプロイフロー
1. GitHub `main` ブランチへ HTML もしくは Terraform の変更がマージされる。
2. CodePipeline が CodeStar Connections を通じてソースを取得。
3. CodeBuild が `buildspec.yml` を用いて `app/` 内の静的ファイルを `dist/` に複製し、サイトバケットへ同期。
4. デプロイ完了後、CloudFront のキャッシュを無効化して最新コンテンツを配信。

## 4. 変数と設定
- `infra/terraform/common/terraform.tfvars`  
  - `project`, `environment`, `aws_region`, `aws_profile`  
  - `notification_emails`, `budget_limit`, `time_unit`, `currency`
- `infra/terraform/pipeline/terraform.tfvars`  
  - `aws_region`, `aws_account_id`  
  - `site_bucket_name`, `artifact_bucket_name`  
  - `github_owner`, `github_repo`, `github_branch`, `connection_arn`  
  - `cloudfront_price_class`, `cloudfront_waf_acl_arn`

## 5. 監視とアラート
- **AWS Budgets**: Amazon EventBridge の月次コストおよび予測値が USD 100 を超過した場合、`atukuwassyoi8726@gmail.com` にメール通知。
- **CloudWatch Logs**: CodeBuild のログを 30 日保持し、失敗時のトラブルシュートに利用。

## 6. 運用手順概要
- コード変更前に `terraform fmt`、`terraform validate` を実行する。
- 新しいメール通知先や閾値変更は `.tfvars` を更新し、PR で共有する。
- クリティカルなインフラ変更は `infra/process-guideline.md` に履歴を追記する。

## 7. 今後の拡張検討
- CloudFront へのカスタムドメイン適用と ACM 証明書の発行。
- CodeBuild のビルド環境を軽量化した Docker イメージへ切り替え、ビルド時間の最適化を図る。
- パイプラインの多段環境化（staging → production）に向けた backend 分離とワークスペース運用。

## 8. 段階的な構築プラン
1. **ベース整備**: `infra/terraform/common` をデプロイし、AWS Budgets の通知が動作することを確認する。`.tfvars` に環境固有値を設定し、`terraform apply` を実施。
2. **パイプライン基盤**: `infra/terraform/pipeline` を適用し、S3 バケット・CloudFront・CodeBuild・CodePipeline・IAM を作成する。CodeStar Connections の ARN を事前に準備する。
3. **静的サイト配置**: `app/` 内の静的 HTML/CSS/JS を整備し、GitHub main ブランチへ push してパイプラインを起動。S3 および CloudFront で表示を確認する。
4. **運用強化**: ログ監視や通知先の追加、CloudFront/WAF 設定のチューニング、将来の複数環境運用に向けた backend 分離を段階的に検討する。

## 9. 入力が必要なユニーク AWS 情報
- `XXXXXXXXXXXX` — Terraform で対象とする AWS アカウント ID。`infra/terraform/pipeline/terraform.tfvars` に入力。
- `store_bucket` / `artifact_store_bucket` / `cloudfront_logs_store_bucket` — S3 バケット名はアカウント内で一意である必要がある。`store_bucket` と `artifact_store_bucket` は tfvars、`cloudfront_logs_store_bucket` はモジュール内部で派生するが、命名規則を満たすか確認。
- `connection_arn` — GitHub 連携に使用する CodeStar Connections の ARN。事前に AWS マネジメントコンソールで発行し、`infra/terraform/pipeline/terraform.tfvars` に設定。
- `cloudfront_waf_acl_arn`（任意） — 連携する AWS WAFv2 Web ACL の ARN を指定する場合に入力。未使用なら空文字列。
- `aws_profile`（任意） — ローカル環境から Terraform を実行する際、特定の AWS CLI プロファイルを使う場合は `infra/terraform/common/terraform.tfvars` に設定。
