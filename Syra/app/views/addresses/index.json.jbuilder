json.array!(@addresses) do |address|
  json.extract! address, :id, :number, :street, :postalCode, :town, :x, :y
  json.url address_url(address, format: :json)
end
