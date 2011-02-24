h = Rufus::Jig::Http.new(URL.host, URL.port, :timeout => 60)
test_http("rufus-jig") do
  data = h.get(URL.path, "X-Test" => "test")
  raise Exception.new unless data.first["number"] != 123123
end
