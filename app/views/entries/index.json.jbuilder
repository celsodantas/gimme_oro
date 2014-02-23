json.array!(@entries) do |entry|
  json.extract! entry, :description, :date, :entry_type, :amount
  json.url entry_url(entry, format: :json)
end
