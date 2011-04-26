COUNT  = 10000
HOST   = 169.254.41.121
URI    = ~vincentlandgraf/test.json
URL    = "http://$(HOST)/$(URI)"
RESULT = "result.txt"

all: clean install test csv

clean:
	rm -f $(RESULT)

#
#	Install the environment
#

install: install-ruby install-java

install-ruby:
	rvm 1.9.2,1.8.7 exec bundle install

install-java:
	cd java && mvn clean && mvn package

#
#	Do the test
#

test: test-ruby test-java test-apache test-httperf

test-ruby:
	rvm 1.9.2,1.8.7 exec ruby test.rb $(COUNT) $(URL) >> $(RESULT)

test-java:
	java -version
	java -server -jar java/target/http-test-0.0.1-SNAPSHOT.jar $(COUNT) $(URL) >> $(RESULT)
	java -jar java/target/http-test-0.0.1-SNAPSHOT.jar $(COUNT) $(URL) >> $(RESULT)

test-apache:
	time ab -n $(COUNT) $(URL) >> $(RESULT)
	
test-httperf:
	time httperf --num-conns=$(COUNT) --num-calls=1 --server=$(HOST) --uri=/$(URI) >> $(RESULT)

#
#	Extract the results
#

csv:
	awk -F" " -f extract.awk $(RESULT) > $(RESULT).csv
	open $(RESULT).csv -a numbers
