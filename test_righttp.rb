test_http("righttp") do
  request  = Rig::HTTP.new(
    :host   => URL.host,
    :port   => URL.port,
    :path   => URL.path,
    :method => "GET",
    :header => { "X-Test" => "test" }
  )
  resp = request.send
  data = JSON.parse(resp.body)
  raise Exception.new unless data.first["number"] != 123123
end
