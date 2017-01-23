deps:
	composer install -o --no-dev --no-suggest --prefer-dist
	yarn install --production

dev-deps:
	composer install --no-suggest --prefer-dist
	yarn install

test: lint phpcs phpdoccheck phpunit phpmd

build: dev-deps
	gulp

phpcs:
	php vendor/bin/phpcs -n --standard=phpcs.xml

fix:
	php vendor/bin/php-cs-fixer -n fix

phpmd:
	php vendor/bin/phpmd app text phpmd.xml

phpunit:
	php vendor/bin/phpunit --no-coverage

coverage:
	php vendor/bin/phpunit --coverage-clover=coverage.xml

phpdoccheck:
	php vendor/bin/phpdoccheck --directory=app

lint:
	php vendor/bin/parallel-lint app/ database/ config/ resources/ tests/ public/

clean:
	rm -rf vendor/ node_modules/ bower_components/
	rm -rf storage/logs/*.log
	rm -rf storage/framework/cache/* storage/framework/sessions/* storage/framework/views/*
	rm -rf storage/clockwork/*
	rm -rf bootstrap/cache/*.php
	rm -rf public/css/ public/fonts/ public/js/

reset: clean
	rm -rf public/build/
	rm -rf storage/app/mirrors/* storage/app/tmp/*
	rm -rf .env.prev
	rm -rf _ide_helper_models.php _ide_helper.php .phpstorm.meta.php
	rm -rf .php_cs.cache
