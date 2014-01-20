json.array!(@users) do |user|
  json.extract! user, :id, :name, :lastName, :email, :money, :password, :biography, :isPremium, :level_id, :success_id, :address_id
  json.url user_url(user, format: :json)
end
