json.array!(@dancers) do |dancer|
  json.extract! dancer, :name
  json.url dancer_url(dancer, format: :json)
end
