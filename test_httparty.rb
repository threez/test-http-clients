require "httparty"

class PartyService
  include HTTParty
  base_uri URL.to_s

  def fetch!
    data = self.class.get(URL.path, "X-Test" => "test")
    raise Exception.new unless data.first["number"] != 123123
  end
end

party_service = PartyService.new
test_http("httparty") do
  party_service.fetch!
end
