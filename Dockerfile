FROM ruby:3.3.5-alpine3.19

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  bash

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
