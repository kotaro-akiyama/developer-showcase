# 開発者ショーケース 要件定義

## 1. 目的と背景
- Web プロダクト「Developer Showcase」のマーケティングサイトと運用基盤を一元管理する。
- インフラ要素（Terraform）、アプリケーション（html）、自動化（CodePipeline）を同一リポジトリで扱い、変更履歴をトレーサブルに保つ。

## 2. スコープ
- フロントエンド: javascript,css,scripts構成で健康食品のホームページを作成する。
- インフラ: AWS（S3、CloudFront、CodePipeline、CodeBuild、Amazon EventBridge のコスト監視）を対象とした IaC。
- 自動化: GitHub リポジトリからの継続的デリバリーパイプライン。

## 3. ステークホルダー
- プロダクトオーナー: 要件優先度の決定とリリース承認。
- 開発チーム: htmlに関わるアプリケーションと Terraform コードの実装。
- SRE / インフラ担当: AWS リソースの管理と監視。

## 4. 機能要件
1. htmlを `/app` 配下で提供すること。
2. GitHub main ブランチへのマージをトリガーに、S3/CloudFront へ自動デプロイするパイプラインを提供すること。
3. Amazon EventBridge の月次実コストおよび予測コストが USD 100 を超える際にメール通知が届くこと。
4. インフラとアプリの設定値は `.tfvars` などで環境ごとに切り替え可能であること。

## 5. 非機能要件
- セキュリティ: S3 バケットはパブリックアクセスブロックを有効化し、CloudFront からのアクセスのみ許可する。
- 運用性: Terraform による変更は `terraform fmt` / `terraform validate` を実行後にレビューへ提出する。
- 可観測性: CodeBuild のログは CloudWatch Logs に 30 日保持する。
- 可用性: CloudFront を活用し、S3 のみで冗長構成を実現する。

## 6. 制約
- 実行環境は AWS を利用し、リージョンは `ap-northeast-1` を優先する。
- コスト管理の通知先メールアドレスは `notification_emails` 変数で管理し、最低 1 件以上を設定する。
- 通知先のメールアドレスは `atukuwassyoi8726@gmail`にする。
- GitHub との連携は AWS CodeStar Connections を利用する。

## 7. 成果物
- html（`app/`）。
- Terraform 構成（`infra/terraform/common/`、`infra/terraform/pipeline/`）。
- 運用ドキュメント（本ドキュメントおよび設計ドキュメント）。

## 8. 未決定事項・TODO
- 本番・ステージングなど複数環境を運用するか否か。
- CloudFront 用カスタムドメインおよび ACM 証明書の導入有無。
- CodeBuild の環境変数を追加する必要がある場合の詳細。
