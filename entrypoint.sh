#!/bin/bash
set -e

# Railsサーバーが残したPIDファイルを削除
# （前回のコンテナが正常に終了しなかった場合に対応）
rm -f /rails-blog/tmp/pids/server.pid

# 渡されたコマンドを実行
exec "$@"

