start:
	rm -rf tmp/pids/server.pid
	bin/rails s -b 0.0.0.0

start-dev:
	rm -rf tmp/pids/server.pid
	bin/rails s

setup:
	bundle install
	yarn install
	yarn build
	yarn build:css
	bin/rails db:migrate
	bin/rails preload:preload_images
	bin/rails db:seed

without-production:
	bundle config set --local without 'production'

setup-without-production: without-production setup
	cp -n .env.github .env || true

cleanup:
	bin/rails db:drop db:create db:migrate
	bin/rails preload:preload_images
	bin/rails db:seed

check: test lint

lint:
	bundle exec rubocop -a
	bundle exec slim-lint app/views/

test:
	bin/rails test

.PHONY: test
