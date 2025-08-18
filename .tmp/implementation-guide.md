# Word Counter 実装計画

## DHH流のRails実装原則

このプロジェクトでは、David Heinemeier Hansson（DHH）が提唱するRailsの哲学に従って実装を進めます。

### 基本原則

1. **The Rails Way** - Railsの規約に従い、独自の実装パターンを避ける
2. **マジェスティックモノリス** - 単一のRailsアプリケーションとして構築
3. **HTMLファースト** - サーバーサイドレンダリングを基本とし、必要に応じてTurbo/Stimulusで強化
4. **最小限のJavaScript** - 複雑なフロントエンドフレームワークは使用せず、Stimulusで十分
5. **シンプルさと読みやすさ** - 巧妙なコードより明快なコードを優先
6. **薄いコントローラー、太いモデル** - ビジネスロジックはモデル層に集約
7. **RESTfulな設計** - リソースベースのルーティングを厳守
8. **ジェネレーターの活用** - `rails generate`コマンドを積極的に使用
9. **ActiveRecordパターン** - ORMの機能を最大限活用し、生SQLは最小限に
10. **Convention over Configuration** - 設定より規約を優先

## 実装手順

### フェーズ1: 基本機能の実装

1. **モデルの作成**
   ```bash
   rails generate model Document title:string content:text word_count:integer
   rails generate model WordCount document:references counted_at:datetime count:integer
   ```

2. **コントローラーの作成**
   ```bash
   rails generate controller Documents index show new create edit update destroy
   ```

3. **ビューの実装**
   - サーバーサイドレンダリングでHTMLを生成
   - Turbo Framesで部分更新を実装
   - 必要最小限のStimulusコントローラーを追加

### フェーズ2: リアルタイム更新機能

1. **Turbo Streamsの実装**
   - 文字数カウントのリアルタイム更新
   - Action Cableは使用せず、Turbo Streamsで実現

2. **Stimulusコントローラー**
   - `word_counter_controller.js` - 文字数カウント
   - シンプルで読みやすいJavaScriptコード

### フェーズ3: 統計機能

1. **統計用モデルメソッド**
   - `Document#calculate_statistics`
   - `Document#word_frequency`
   - ビジネスロジックはモデルに集約

2. **統計表示**
   - サーバーサイドでグラフデータを生成
   - HTMLとCSSで可能な限り表現

## ディレクトリ構造

```
app/
├── controllers/
│   ├── application_controller.rb
│   └── documents_controller.rb  # RESTfulアクション
├── models/
│   ├── application_record.rb
│   ├── document.rb              # ビジネスロジック
│   └── word_count.rb
├── views/
│   ├── documents/
│   │   ├── index.html.erb
│   │   ├── show.html.erb
│   │   ├── new.html.erb
│   │   ├── edit.html.erb
│   │   └── _form.html.erb      # パーシャルで共通化
│   └── layouts/
│       └── application.html.erb
└── javascript/
    └── controllers/
        └── word_counter_controller.js  # 最小限のJS

```

## コーディング規約

### Ruby/Rails
- Rubocopの標準設定に従う
- メソッドは5行以内を目標
- クラスは100行以内を目標
- 早期リターンを活用
- 三項演算子は単純な場合のみ使用

### HTML/ERB
- セマンティックHTMLを使用
- インラインスタイルは避ける
- Turbo FrameとTurbo Streamを活用

### JavaScript
- Stimulusの規約に従う
- ES6+の機能を活用
- 外部ライブラリは最小限に

## テスト戦略

1. **モデルテスト**
   - 全てのビジネスロジックをテスト
   - RSpecではなくMinitestを使用（Rails標準）

2. **システムテスト**
   - ユーザーフローをE2Eでテスト
   - Capybaraを使用

3. **コントローラーテスト**
   - 必要最小限のテスト
   - 統合テストでカバー

## デプロイ戦略

1. **Kamalを使用**
   - DHH推奨のデプロイツール
   - Dockerコンテナでデプロイ

2. **PostgreSQLを使用**
   - 本番環境での安定性
   - ActiveRecordと相性が良い

3. **Redisは最小限**
   - キャッシュとActionCableのみ
   - 可能な限りDBで完結

## パフォーマンス最適化

1. **N+1問題の回避**
   - `includes`、`preload`、`eager_load`を適切に使用

2. **キャッシュの活用**
   - フラグメントキャッシュ
   - ロシアンドールキャッシング

3. **データベースインデックス**
   - 適切なインデックスを設定
   - `explain`で確認

## セキュリティ

1. **Strong Parameters**
   - 全てのパラメータをホワイトリスト化

2. **CSRF対策**
   - Rails標準の対策を使用

3. **XSS対策**
   - ERBの自動エスケープに依存
   - `raw`や`html_safe`は最小限に

## まとめ

このプロジェクトは、DHHが提唱する「The Rails Way」に従い、シンプルで保守しやすく、かつ強力なWebアプリケーションを構築します。複雑さを避け、Railsの規約とツールを最大限活用することで、開発速度と品質の両立を目指します。