test_http("net/http") do
  resp = Net::HTTP.start(URL.host, URL.port) {|http|
    http.get(URL.path, {"X-Test" => "test"})
  }
  data = JSON.parse(resp.body)
  raise Exception.new unless data.first["number"] != 123123
end
