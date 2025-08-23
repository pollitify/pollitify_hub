# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.3
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Install dependencies needed for gems + node + postgres + imagemagick
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential curl git nodejs yarn postgresql-client libpq-dev \
    imagemagick libmagickwand-dev python3 libyaml-dev && \
    rm -rf /var/lib/apt/lists/*    

# Set bundler path and PATH for runtime
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development:test" \
    PATH=/usr/local/bundle/bin:$PATH

# Install bundler
RUN gem install bundler -v 2.6.3

# Copy Gemfile and lockfile first (Docker layer caching)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the app
COPY . .

ENV RAILS_MASTER_KEY=dummy
ENV SECRET_KEY_BASE=dummy

# Precompile assets
RUN ./bin/rails assets:precompile

# Non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails

# Entrypoint and default CMD
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/thrust", "./bin/rails", "server"]



# FROM ruby:3.4.3-slim AS base
# WORKDIR /rails
#
# # Install dependencies
# RUN apt-get update -qq && apt-get install --no-install-recommends -y \
#     build-essential curl git nodejs yarn postgresql-client libpq-dev imagemagick libmagickwand-dev && \
#     rm -rf /var/lib/apt/lists/*
#
# # Set bundler path
# ENV BUNDLE_PATH=/usr/local/bundle \
#     BUNDLE_WITHOUT="development:test" \
#     PATH=$BUNDLE_PATH/bin:$PATH
#
# # Copy app and install gems
# COPY Gemfile Gemfile.lock ./
# RUN gem install bundler -v 2.6.3
# RUN bundle install --jobs 4 --retry 3
#
# # Copy the rest of the app
# COPY . .
#
# # Precompile assets
# RUN ./bin/rails assets:precompile
#
# # Set non-root user
# RUN groupadd --system --gid 1000 rails && \
#     useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
#     chown -R rails:rails /rails
#
# USER rails
#
# # Entrypoint
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]
# CMD ["./bin/thrust", "./bin/rails", "server"]



# # syntax=docker/dockerfile:1
# # check=error=true
#
# # This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# # docker build -t rails_8_authentication .
# # docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name rails_8_authentication rails_8_authentication
#
# # For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html
#
# # Make sure RUBY_VERSION matches the Ruby version in .ruby-version
# ARG RUBY_VERSION=3.4.3
# FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base
#
# # Rails app lives here
# WORKDIR /rails
#
# # Install base packages
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y curl iputils-ping libyaml-dev libjemalloc2 libvips sqlite3 postgresql-client postgresql-contrib imagemagick libmagickwand-dev libpq-dev && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
# # Set production environment
# ENV RAILS_ENV="production" \
#     BUNDLE_DEPLOYMENT="1" \
#     BUNDLE_PATH="/usr/local/bundle" \
#     BUNDLE_WITHOUT="development"
#
# # Throw-away build stage to reduce size of final image
# FROM base AS build
#
# # Install packages needed to build gems and node modules
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y build-essential nano git node-gyp pkg-config python-is-python3 postgresql-client postgresql-contrib libpq-dev imagemagick  libmagickwand-dev sudo && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
# # Install JavaScript dependencies
# ARG NODE_VERSION=22.14.0
# ARG YARN_VERSION=1.22.22
# ENV PATH=/usr/local/node/bin:$PATH
# RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
#     /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
#     npm install -g yarn@$YARN_VERSION && \
#     rm -rf /tmp/node-build-master
#
# # Install application gems
# COPY Gemfile Gemfile.lock ./
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile
#
# # suggestion from claude
# COPY config/credentials.yml.enc config/credentials.yml.enc
#
# # Install node modules
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile
#
# # Copy application code
# COPY . .
#
# # Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/
#
# # Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN DISABLE_DATABASE_ENVIRONMENT_CHECK=1 HONEYBADGER_API_KEY=1 SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
#
#
# RUN rm -rf node_modules
#
#
# # Final stage for app image
# FROM base
#
# # Copy built artifacts: gems, application
# COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
# COPY --from=build /rails /rails
#
#
# # Run and own only the runtime files as a non-root user for security
# RUN groupadd --system --gid 1000 rails && \
#     useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
#
#
# #
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile
#
#
# RUN chmod +rx /rails/bin
#
# USER 1000:1000
#
# # Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
# # Start server via Thruster by default, this can be overwritten at runtime
# EXPOSE 80
# CMD ["./bin/thrust", "./bin/rails", "server"]
