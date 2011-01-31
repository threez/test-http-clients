require 'rubygems'
require 'uri'
require 'benchmark'
require 'yajl'
require 'yajl/json_gem'

ITERATIONS = 10

def test_http(name, &block)
  Benchmark.bm do |x|
    x.report("testing #{name}") do
      ITERATIONS.times(&block)
    end
  end
end

URL = URI.parse("http://toevolve.org/test.json")
