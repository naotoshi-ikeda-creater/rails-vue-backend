FROM ruby:2.6.5

# for rails v6
# RUN apt-get update -qq && apt-get install -y nodejs yarnpkg
# RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn

# for rails v5
RUN apt-get update -qq && \
    apt-get install -y build-essential \
    libpq-dev \
    nodejs
RUN mkdir /backend
WORKDIR /backend
COPY Gemfile /backend/Gemfile
COPY Gemfile.lock /backend/Gemfile.lock
RUN bundle install -j4
COPY . /backend

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]