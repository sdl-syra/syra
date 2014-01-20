json.array!(@propositions) do |proposition|
  json.extract! proposition, :id, :isPaid, :isAccepted, :motifCancelled, :proposition, :comment, :user_id, :service_id
  json.url proposition_url(proposition, format: :json)
end
