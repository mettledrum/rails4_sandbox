json.array!(@team_heats) do |team_heat|
  json.extract! team_heat, :team_id, :heat_id, :judge_id, :score
  json.url team_heat_url(team_heat, format: :json)
end
