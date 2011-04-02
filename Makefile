COUNT	= 10
URL		= "http://localhost/~vincentlandgraf/test.json"
DATE	 = `date +%Y-%m-%d.%H-%M`
RESULT = "result-$(DATE).txt"

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

test: test-ruby test-java test-apache

test-ruby:
	rvm 1.9.2,1.8.7 exec ruby test.rb $(COUNT) $(URL) >> $(RESULT)

test-java:
	java -version
	java -server -jar java/target/http-test-0.0.1-SNAPSHOT.jar $(COUNT) $(URL) >> $(RESULT)
	java -jar java/target/http-test-0.0.1-SNAPSHOT.jar $(COUNT) $(URL) >> $(RESULT)

test-apache:
	ab -n $(COUNT) $(URL) >> $(RESULT)

#
#	Extract the results
#

csv:
	awk -F" " -f extract.awk $(RESULT) > $(RESULT).csv
	open $(RESULT).csv -a numbers
