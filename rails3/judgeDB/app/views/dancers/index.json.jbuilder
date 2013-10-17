json.array!(@dancers) do |dancer|
  json.extract! dancer, :name, :email
  json.url dancer_url(dancer, format: :json)
end
