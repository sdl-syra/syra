json.array!(@services) do |service|
  json.extract! service, :id, :title, :price, :description, :disponibility, :isGiven, :isFinished, :address_id, :category_id, :user_id
  json.url service_url(service, format: :json)
end
