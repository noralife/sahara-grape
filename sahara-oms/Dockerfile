FROM ruby:2.2.0
MAINTAINER Tatsuya Nanjo <noralife@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /sahara-oms
RUN mkdir /sahara-oms/tmp
WORKDIR /sahara-oms
ADD . /sahara-oms
RUN bundle install -j4 --without development test
EXPOSE 30303
CMD ["bundle", "exec", "rackup", "-p", "30303", "-o", "0.0.0.0"]
