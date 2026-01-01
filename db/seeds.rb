# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating sample data..."

# Clear existing data
Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "Creating users..."

users = [
  { name: "田中太郎", email: "tanaka@example.com", password: "password123" },
  { name: "佐藤花子", email: "sato@example.com", password: "password123" },
  { name: "鈴木一郎", email: "suzuki@example.com", password: "password123" },
  { name: "山田美咲", email: "yamada@example.com", password: "password123" }
]

created_users = users.map do |user_attrs|
  User.create!(user_attrs)
end

puts "Created #{User.count} users"

puts "Creating posts..."

posts_data = [
  {
    title: "Ruby on Railsを始めよう",
    body: <<~BODY
      Ruby on Railsは、Rubyで書かれたWebアプリケーションフレームワークです。

      MVCアーキテクチャを採用しており、開発者が効率的にWebアプリケーションを構築できるように設計されています。

      Railsの特徴：
      - Convention over Configuration（設定より規約）
      - DRY（Don't Repeat Yourself）
      - RESTfulなルーティング
      - Active Recordによるデータベース操作

      これからRailsを学ぶ方は、まず公式ガイドを読むことをお勧めします。
    BODY
  },
  {
    title: "Dockerで開発環境を構築する方法",
    body: <<~BODY
      Dockerを使うと、開発環境を簡単に構築・共有できます。

      今回のブログアプリでは、以下の構成でDocker環境を構築しました：
      - Ruby 3.3
      - Rails 7.2
      - SQLite

      docker-compose.ymlを使うことで、一つのコマンドで環境を立ち上げることができます。

      チーム開発では、全員が同じ環境で開発できるため、「自分の環境では動く」という問題を防ぐことができます。
    BODY
  },
  {
    title: "Deviseで認証機能を実装する",
    body: <<~BODY
      Deviseは、Railsで最も人気のある認証ライブラリです。

      基本的な機能：
      - ユーザー登録
      - ログイン・ログアウト
      - パスワードリセット
      - アカウント確認メール

      インストールは簡単で、Gemfileにdeviseを追加してbundle installするだけです。

      カスタマイズも柔軟で、ビューやコントローラーを自分好みに変更できます。
    BODY
  },
  {
    title: "プログラミング学習のコツ",
    body: <<~BODY
      プログラミングを効率的に学ぶためのコツをご紹介します。

      1. 毎日少しずつ続ける
      一度に長時間やるより、毎日30分でも続ける方が効果的です。

      2. 実際に手を動かす
      チュートリアルを読むだけでなく、実際にコードを書いてみましょう。

      3. エラーを恐れない
      エラーは学びのチャンスです。エラーメッセージを読んで原因を探りましょう。

      4. アウトプットする
      ブログを書いたり、GitHubにコードを公開したりすることで、知識が定着します。

      一緒に頑張りましょう！
    BODY
  },
  {
    title: "RESTful APIの設計について",
    body: <<~BODY
      RESTful APIは、Webサービスを設計する際の重要な概念です。

      基本原則：
      - リソース指向の設計
      - HTTPメソッドの適切な使用（GET, POST, PUT, DELETE）
      - ステートレスな通信
      - 統一されたインターフェース

      Railsでは、resourcesメソッドを使うことで、RESTfulなルーティングを簡単に定義できます。

      適切なAPI設計は、フロントエンドとの連携やモバイルアプリの開発をスムーズにします。
    BODY
  },
  {
    title: "CSSで美しいダークテーマを作る",
    body: <<~BODY
      最近のWebサイトでは、ダークテーマが人気です。

      ダークテーマのメリット：
      - 目の疲れを軽減
      - バッテリー消費を抑える（OLEDディスプレイの場合）
      - モダンな印象を与える

      実装のポイント：
      - CSS変数を活用して色を一元管理
      - 純粋な黒（#000）より、少しグレーがかった色を使う
      - アクセントカラーで視認性を確保

      このブログアプリでも、ダークテーマを採用しています。
    BODY
  }
]

posts_data.each_with_index do |post_data, index|
  user = created_users[index % created_users.length]
  Post.create!(
    title: post_data[:title],
    body: post_data[:body],
    user: user,
    created_at: (posts_data.length - index).days.ago
  )
end

puts "Created #{Post.count} posts"

puts "Creating comments..."

comments_data = [
  "とても参考になりました！ありがとうございます。",
  "わかりやすい解説ですね。早速試してみます。",
  "質問があるのですが、もう少し詳しく教えていただけますか？",
  "素晴らしい記事ですね！シェアさせていただきます。",
  "この方法で解決できました。感謝です！",
  "初心者にもわかりやすい説明でした。",
  "追加情報があれば教えてください。",
  "私も同じ問題に悩んでいたので助かりました。"
]

Post.all.each do |post|
  rand(2..4).times do
    commenter = created_users.reject { |u| u == post.user }.sample
    Comment.create!(
      body: comments_data.sample,
      user: commenter,
      post: post,
      created_at: rand(1..48).hours.ago
    )
  end
end

puts "Created #{Comment.count} comments"

puts "Sample data created successfully!"
puts ""
puts "You can log in with any of these accounts:"
puts "- Email: tanaka@example.com, Password: password123"
puts "- Email: sato@example.com, Password: password123"
puts "- Email: suzuki@example.com, Password: password123"
puts "- Email: yamada@example.com, Password: password123"
