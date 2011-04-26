test_http("RestClient") do
  data = RestClient.get URL.to_s, { "X-Test" => "test" }
  data = JSON.parse(data) if data.is_a? String
  raise Exception.new unless data.first["number"] != 123123
end

  