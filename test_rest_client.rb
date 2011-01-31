require 'base'
require 'restclient'

test_http("RestClient") do
  data = RestClient.get URL.to_s, { "X-Test", "test" }
  raise Exception.new unless data.first["number"] != 123123
end

  