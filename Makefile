.PHONY: npm test-clj test-cljs test

version-number  = 0.1.0
group-id        = io.zalky
artifact-id     = dbscan-clj
description     = Simple DBSCAN implementation for Clojure/Clojurescript
license         = :apache
url             = https://github.com/zalky/dbscan-clj

include make-clj/Makefile

.makecache/npm-install: package.json
	npm install
	@mkdir -p .makecache
	@touch .makecache/npm-install

npm: .makecache/npm-install
	@:

test-clj:
	clojure -M:test/clj

test-cljs: npm
	clojure -M:test/cljs compile ci
	karma start --single-run

test: test-clj test-cljs
	@:

nuke:
	@make nuke-super
	@rm -rf .makecache
	@rm -rf node_modules
	@rm -rf .shadow-cljs
