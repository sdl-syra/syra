json.array!(@hobbies) do |hobby|
  json.extract! hobby, :id, :label
  json.url hobby_url(hobby, format: :json)
end
