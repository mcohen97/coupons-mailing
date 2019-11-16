# gets the docker image of ruby 2.5 and lets us build on top of that
FROM ruby:2.6.4-slim

# install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev
RUN gem install bundler

RUN mkdir /application
WORKDIR /application

COPY Gemfile /application/Gemfile
COPY Gemfile.lock /application/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN bundle install

# Copy the whole app
COPY . /application