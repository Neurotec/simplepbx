FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /simplepbx
WORKDIR /simplepbx
ADD Gemfile /simplepbx/Gemfile
ADD Gemfile.lock /simplepbx/Gemfile.lock
RUN bundle install
ADD . /simplepbx
