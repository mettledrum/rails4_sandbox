json.array!(@judges) do |judge|
  json.extract! judge, :name
  json.url judge_url(judge, format: :json)
end
