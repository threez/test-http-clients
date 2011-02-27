COUNT = 10000
URL   = "http://localhost/~vincentlandgraf/test.json"

all: install test-ruby test-java test-apache

install:
	rvm 1.9.2,1.8.7 exec bundle install
	cd java && mvn clean && mvn package

test-ruby:
	rvm 1.9.2,1.8.7 exec ruby test.rb $(COUNT) $(URL)

test-java:
	java -version
	java -server -jar java/target/http-test-0.0.1-SNAPSHOT.jar $(COUNT) $(URL)

test-apache:
	ab -n $(COUNT) $(URL)
