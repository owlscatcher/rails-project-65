#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:drop db:create db:migrate DISABLE_DATABASE_ENVIRONMENT_CHECK=1
bin/rails preload:preload_images
bundle exec rails db:seed
