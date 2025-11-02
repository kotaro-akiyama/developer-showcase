# インフラ運用メモ

## ディレクトリ構成
- `infra/terraform/common/` — 共有変数やベースライン設定を管理。環境ごとの設定は `terraform.tfvars` を利用。
- `infra/terraform/pipeline/` — GitHub 連携パイプライン（S3/CloudFront/CodePipeline/CodeBuild）用のメインスタック。`main.tf` などの可変レイヤーから `modules/static_site_pipeline/`（不可変レイヤー）を呼び出す構成。
- `ansible/`, `scripts/` — 今後の拡張用。必要になり次第、このファイルに運用手順を追記する。

## 変更履歴
- 2025-11-02: `infra/terraform/common/` に Terraform の初期構成（`versions.tf`、`main.tf`、`variables.tf`、`outputs.tf`、`terraform.tfvars.example`）を追加し `terraform fmt` 済み。
- 2025-11-02: `infra/terraform/pipeline/` に GitHub 連携のデプロイパイプラインスタックを追加。S3/CloudFront/OAC、CodeBuild、CodePipeline、IAM ロールとポリシー、buildspec サンプルを作成。
- 2025-11-02: ベースライン設定を `infra/terraform/common/` に集約し、役割が分かる命名へ整理。パイプラインスタックを同一パス配下へ移動。
- 2025-11-02: パイプラインスタックを可変レイヤー（ルート）と不可変レイヤー（`modules/static_site_pipeline`）に分割し、再利用しやすい構成に再編。
