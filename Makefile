COUNT = 1000
URL   = "http://localhost/~vincentlandgraf/test.json"

all: install test apache-bench
	
install:
	rvm 1.9.2,1.8.7 exec bundle install

test:
	rvm 1.9.2,1.8.7 exec ruby test.rb $(COUNT) $(URL)

apache-bench:
	ab -n $(COUNT) $(URL)
