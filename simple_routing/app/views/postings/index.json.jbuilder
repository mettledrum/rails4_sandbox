json.array!(@postings) do |posting|
  json.extract! posting, :id, :title, :content, :user_id
  json.url posting_url(posting, format: :json)
end
