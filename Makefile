binstub:
	bundle binstubs rspec-core --path exe

count:
	find . -type f -name "*.rb" | xargs cat | sed "/^\s*\(#\|\$\)/d" | wc -l
