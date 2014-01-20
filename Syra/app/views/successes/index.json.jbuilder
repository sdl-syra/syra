json.array!(@successes) do |success|
  json.extract! success, :id, :label, :urlImageValidate, :urlImageUnvalidate, :locked, :user_id
  json.url success_url(success, format: :json)
end
