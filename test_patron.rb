require 'patron'

sess = Patron::Session.new
test_http("patron") do
  sess.headers["X-Test"] = "test"
  resp = sess.get(URL.to_s)
  data = JSON.parse(resp.body)
  raise Exception.new unless data.first["number"] != 123123
end
