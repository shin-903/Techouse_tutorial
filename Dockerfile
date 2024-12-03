FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

# ポート3000でアプリを起動
EXPOSE 3000

# コンテナ起動時にRailsサーバーを実行
CMD ["rails", "server", "-b", "0.0.0.0"]

# # EXPOSEで3003番ポートを公開
# EXPOSE 3003

# # Railsサーバーを指定されたポートで起動
# CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -p ${PORT:-3003} -b '0.0.0.0'"]https://github.com/shin-903/Techouse_tutorial/pull/13/files#diff-a64cf250b418ab8feee6c682a3d8cbd3b72cf24d4a241adeaf35c98b84045f93