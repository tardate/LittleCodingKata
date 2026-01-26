default: info run_tests

info:
	@bundle exec ruby --version
	@echo
	@bundle exec rspec --version
	@echo

run_tests:
	bundle exec rake

book:
	(cd .. && make)

check:
	(cd .. && make check)

consist:
	(cd .. && make consist)

lint:
	(cd .. && make lint)

# Run one target that creates YARD documentation in /tmp
#
yard-doc:
	rm -rf /tmp/eruby2-yard
	mkdir -p /tmp/eruby2-yard/lib
	sed -e '/START:/d' -e '/END:/d' <01/yard_comments.rb >/tmp/eruby2-yard/lib/document.rb
	(cd /tmp/eruby2-yard && yard)

test:
	echo $(RubyTargets)

clean:
	rake clean
