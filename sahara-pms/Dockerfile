FROM ruby:2.2.0
MAINTAINER Tatsuya Nanjo <noralife@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /sahara-pms
RUN mkdir /sahara-pms/tmp
WORKDIR /sahara-pms
ADD . /sahara-pms
RUN bundle install -j4 --without development test
EXPOSE 3002
CMD ["bundle", "exec", "rackup", "-p", "3002", "-o", "0.0.0.0"]
