json.array!(@notifications) do |notification|
  json.extract! notification, :id, :id, :user, :label, :glyph_cat, :url, :date, :is_checked
  json.url notification_url(notification, format: :json)
end
