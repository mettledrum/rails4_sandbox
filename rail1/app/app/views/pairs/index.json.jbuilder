json.array!(@pairs) do |pair|
  json.extract! pair, :dancer1_id, :dancer2_id
  json.url pair_url(pair, format: :json)
end
