FROM ruby:2.7.0-alpine3.11 as rails-base

RUN apk update
RUN gem update bundler

# == builder
FROM rails-base as builder

WORKDIR /builder

RUN apk add --update \
    build-base \
    mysql-dev \
    tzdata \
    git

COPY Gemfile Gemfile.lock ./
RUN bundle install -j4

# == main
FROM rails-base

WORKDIR /work/app

RUN apk add --update \
     mysql-client \
     mysql-dev

# Copy from source files
COPY . /work/app

# Copy from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle

EXPOSE 3000
CMD ["bin/rails", "s", "-b", "0.0.0.0"]

