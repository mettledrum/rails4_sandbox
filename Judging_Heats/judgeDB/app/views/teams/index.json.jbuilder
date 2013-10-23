json.array!(@teams) do |team|
  json.extract! team, :given_number
  json.url team_url(team, format: :json)
end
