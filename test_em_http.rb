#evm_count = ITERATIONS
#EventMachine.run do
#  test_http("em-http") do
#    http = EventMachine::HttpRequest.new(URL.to_s).get \
#      :head => {"X-Test" => "test"}, :timeout => 60
#
#    http.callback do
#      data = JSON.parse(http.response)
#      raise Exception.new unless data.first["number"] != 123123
#      evm_count -= 1
#      EventMachine.stop if evm_count <= 0
#    end
#  end
#end
