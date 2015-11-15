FROM ruby:2.2

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 0 

WORKDIR /tmp
COPY ourRailsApp/Gemfile Gemfile
COPY ourRailsApp/Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir -p /usr/src/app
COPY ourRailsApp /usr/src/app/
WORKDIR /usr/src/app


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
