json.array!(@dancer_teams) do |dancer_team|
  json.extract! dancer_team, :team_id, :dancer_id
  json.url dancer_team_url(dancer_team, format: :json)
end
