FROM ruby:2.2.0
MAINTAINER Tatsuya Nanjo <noralife@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /sahara-cms
RUN mkdir /sahara-cms/tmp
WORKDIR /sahara-cms
ADD . /sahara-cms
RUN bundle install -j4 --without development test
EXPOSE 30301
CMD ["bundle", "exec", "rackup", "-p", "30301", "-o", "0.0.0.0"]
