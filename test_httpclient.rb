require 'base'
require 'httpclient'

client = HTTPClient.new
test_http("httpclient") do
  client = HTTPClient.new
  resp = client.get_content(URL, nil, "X-Test" => "test")
  data = JSON.parse(resp)
  raise Exception.new unless data.first["number"] != 123123
end
