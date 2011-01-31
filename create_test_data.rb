require "rubygems"
require "json"

def dr           
  {
     "time" => Time.now,
     "string" => "X" * 1000,
     "numbers" => 123123,
     "float" => 123123.123123123,
     "bool" => true,
  }
end

File.open("test.json", "w") do |f|
  f.write(Array.new(15) { dr }.to_json)
end
