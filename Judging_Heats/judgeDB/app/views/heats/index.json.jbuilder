json.array!(@heats) do |heat|
  json.extract! heat, :level
  json.url heat_url(heat, format: :json)
end
