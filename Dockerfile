FROM ruby:2.7.1
RUN apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /huntogether
WORKDIR /huntogether
COPY Gemfile /huntogether/Gemfile
COPY Gemfile.lock /huntogether/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /huntogether

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
