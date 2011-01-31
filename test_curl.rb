test_http("curl") do
  header = {"X-Test" => "test"}
  header_str = ""
  header.each { |key, value| header_str += "-H \"#{key}: #{value}\" "}
  response = `curl #{header_str} -s #{URL.to_s.inspect}`
  data = JSON.parse(response)
  raise Exception.new unless data.first["number"] != 123123
end
