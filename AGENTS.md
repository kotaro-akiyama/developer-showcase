# リポジトリ運用ガイドライン

> **注記:** この文書は基本的に日本語で閲覧・更新してください。
> Codex エージェントの出力も日本語表記を維持してください。
> 簡単なファイル作成や追記は、承認なしで自動対応して構いません。
> 既存リソースの削除や大きなディレクトリ移動など重大な変更を行う前には、必ず事前に確認を取ってください。

## プロジェクト構成とモジュール整理
- `app/` — Next.js App Router のエントリポイント。`layout.tsx` で共通レイアウトを設定し、`globals.css` にグローバルスタイルを定義する。
- `app/components/` — プレゼンテーショナルおよびインタラクティブなブロック群。画面単位でまとめ、機能を跨いだ不要な import は避ける。
- `app/lib/` — 型付き設定 (`site-config.ts`) やデータヘルパーを配置する場所。コンポーネントからは副作用を排除する。
- `infra/` — 運用コードの足場。IaC は `terraform/`、構成管理は `ansible/`、自動化は `scripts/` に配置し、変更点は `infra/README.md` に記録する。

## ビルド・テスト・開発コマンド
- Node 20 以上を使用し、Next.js 標準スクリプトを `package.json` に定義する。
- `npm install` — ワークスペースの依存関係をインストールする。
- `npm run dev` — Next.js の開発サーバーをホットリロード付きで `http://localhost:3000` に起動する。
- `npm run lint` — ESLint + Prettier を実行する。コミット前に必ず走らせる。
- `npm run build` — 本番環境向けのバンドルを作成する。
- `npm run test` — Jest スイートを実行する（テストが整備され次第）。
- インフラ変更時は `infra/terraform` で `terraform fmt && terraform validate` をコミット前に実行する。

## コーディングスタイルと命名規則
- TypeScript は strict mode、インデントは 2 スペース、React は関数コンポーネントをデフォルトとする。
- ファイル／フォルダー名はケバブケース、公開シンボルは PascalCase もしくは camelCase とする。
- スタイル・テスト・フィクスチャは対象コンポーネントと同じ場所に置き、`npm run lint` で整形を徹底する。

## テストガイドライン
- コンポーネントのスペックは実装の隣に `ComponentName.test.tsx` 形式で配置する。
- E2E フローは `tests/e2e/` にルート構成を鏡写しにして追加する（例: `tests/e2e/home.spec.ts`）。
- 新しい挙動はテストで担保するか、先送りする場合は `// @todo-test <issue-link>` コメントを残し、共通ライブラリや重要なユーザージャーニーはカバレッジ 85% 以上を目標とする。

## コミットおよび Pull Request ガイドライン
- コミットメッセージは Conventional Commit (`feat:`, `fix:`, `chore:`, `infra:`) を採用し、サブジェクトは 72 文字以内に収める。
- PR では意図を説明し、`Closes #123` の形式で課題を紐付け、UI/インフラ変更にはスクリーンショットやターミナル出力を添付する。
- レビュー依頼前に `npm run lint`、`npm run build`、関連テストをローカルで検証し、PR のスコープを集中させる。

## セキュリティと設定のヒント
- `.env*` をコミットしない。シークレットはデプロイ基盤やシークレットマネージャーで配布する。
- `infra/terraform` をソースオブトゥルースとして扱い、リモートステートを使用し、`terraform plan` の差分を PR で共有する。
