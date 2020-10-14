FROM ruby:2.7.1

# https://yarnpkg.com/lang/en/docs/install/#debian-stable
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y nodejs postgresql-client vim && \
  apt-get install -y yarn && \
  apt-get install -y imagemagick && \
  apt-get install -y libvips-tools

ENV APP_PATH=/app
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock package.json ${APP_PATH}/
RUN bundle config --local disable_platform_warnings true && bundle install
RUN yarn install --pure-lockfile

# copy the app files after bundle/yarn install to take full advantage of docker cache layers
COPY . ${APP_PATH}

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
