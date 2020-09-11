require 'json'

json_string = File.read("#{Rails.root}/rushing.json")
json = JSON.parse(json_string)

json.each do |record|
  record_hash = record.map { |k,v| [Rushing::MAPPINGS.invert[k], v] }.to_h
  Rushing.create! record_hash
end