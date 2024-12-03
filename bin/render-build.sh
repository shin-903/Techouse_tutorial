# # docker用のビルドスクリプト
# #!/usr/bin/env bash
# # exit on error
# set -o errexit

# # 必要なDocker操作を記述
# docker-compose run --rm web bundle install
# docker-compose run --rm web bundle exec rails assets:precompile
# docker-compose run --rm web bundle exec rails assets:clean
# docker-compose run --rm web bundle exec rails db:create     # データベース作成
# docker-compose run --rm web bundle exec rails db:migrate
