json.array!(@levels) do |level|
  json.extract! level, :id, :levelUser, :XPUser, :user_id
  json.url level_url(level, format: :json)
end
