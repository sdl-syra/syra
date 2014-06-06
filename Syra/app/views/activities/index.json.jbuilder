json.array!(@activities) do |activity|
  json.extract! activity, :id, :user_id, :label, :glyph_cat, :date
  json.url activity_url(activity, format: :json)
end
