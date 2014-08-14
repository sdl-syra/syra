json.array!(@badges) do |badge|
  json.extract! badge, :id, :label, :locked
  json.url badge_url(badge, format: :json)
end
