json.array!(@reports) do |report|
  json.extract! report, :id, :category, :content, :service_id
  json.url report_url(report, format: :json)
end
