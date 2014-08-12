json.array!(@treads) do |tread|
  json.extract! tread, :id, :subject, :user_id, :hobby_id
  json.url tread_url(tread, format: :json)
end
