FROM ruby:3.0.0

LABEL maintainer="denis.jean@ecairn.com"

# Update for security reason
RUN apt-get update -yqq && apt-get upgrade -yqq -o Dpkg::Options::="--force-confold" && apt-get install -yqq --no-install-recommends \
  vim # needed for editing rails credentials

# Ensure we install an up-to-date version of Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# Ensure latest packages for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT

COPY Gemfile* /var/www/app/
WORKDIR /var/www/app

ENV BUNDLE_PATH /gems

RUN bundle install

COPY . /var/www/app/

EXPOSE 3000

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma/development.rb"]
