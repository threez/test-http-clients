require 'rubygems'
require 'uri'
require 'benchmark'
require 'yajl'
require 'yajl/json_gem'

ITERATIONS = 1000
TESTS = []

def test_http(name, &block)
  TESTS << [name, block]
end

URL = URI.parse("http://localhost/~vincentlandgraf/test.json")

dir = File.dirname(__FILE__)

Dir[File.join(dir, "test_*.rb")].each do |file|
  require file
end

at_exit do
  Benchmark.bm(20) do |x|
    for name, block in TESTS do
      x.report("testing #{name}") do
        ITERATIONS.times(&block)
      end
    end
  end
end
