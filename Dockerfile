# 開発・本番共通。docker-compose で開発、本番は docker build -t app . でビルド

ARG RUBY_VERSION=3.3.10
FROM docker.io/library/ruby:${RUBY_VERSION}-slim

WORKDIR /rails

# ランタイム + ネイティブ拡張ビルド用（bindex, nokogiri 等）
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      git \
      libvips \
      libyaml-dev \
      pkg-config \
      sqlite3 \
      tzdata \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV BUNDLE_PATH=/usr/local/bundle \
    PATH="/rails/bin:/usr/local/bundle/bin:$PATH"

# development/test 含め全 gem をインストール（BUNDLE_WITHOUT なし）
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
