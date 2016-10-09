server:
	@(thin start -p 9002 -V)

reinstall_local:
	@(rm db/pipefish_api_development.db)
	@(bundle install)
	@(cd tests && bundle install --without production)
	@(rake db:migrate)

install:
	@(bundle install --without production)
	@(cd tests && bundle install --without production)
	@(rake db:migrate)

update:
	@(bundle install)
	@(cd tests && bundle install)
