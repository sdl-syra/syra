json.array!(@opinions) do |opinion|
  json.extract! opinion, :id, :avis, :note, :service_id
  json.url opinion_url(opinion, format: :json)
end
