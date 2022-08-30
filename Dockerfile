FROM ruby:3.1.2-alpine3.16

ENV APP_PATH /app
ENV BUNDLE_VERSION 2.1.3
ENV RAILS_PORT 3000

RUN apk -U add --no-cache \
build-base \
git \
mariadb-dev \
mariadb-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
tzdata \
less \
&& rm -rf /var/cache/apk/*

RUN gem install bundler --version "$BUNDLE_VERSION"

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . $APP_PATH

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
