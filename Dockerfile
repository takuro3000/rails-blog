# Ruby 3.3をベースイメージとして使用
FROM ruby:3.3-slim

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libsqlite3-dev \
    sqlite3 \
    nodejs \
    npm \
    curl \
    libyaml-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# 作業ディレクトリを設定
WORKDIR /rails-blog

# Bundlerの設定
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    PATH=/bundle/bin:$PATH

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Gemをインストール
RUN bundle install

# entrypointスクリプトをコピー
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# アプリケーションのソースコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
