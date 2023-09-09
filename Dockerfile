FROM ruby:3.1

RUN mkdir /foodmatchapp
WORKDIR /foodmatchapp
COPY Gemfile /foodmatchapp/Gemfile
COPY Gemfile.lock /foodmatchapp/Gemfile.lock

RUN gem update --system
RUN bundle update --bundler

RUN bundle install
COPY . /foodmatchapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
