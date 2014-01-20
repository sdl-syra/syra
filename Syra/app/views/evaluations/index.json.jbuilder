json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :note, :comment, :proposition_id
  json.url evaluation_url(evaluation, format: :json)
end
