FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

# # EXPOSEで3003番ポートを公開
# EXPOSE 3003

# # Railsサーバーを指定されたポートで起動
# CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -p ${PORT:-3003} -b '0.0.0.0'"]