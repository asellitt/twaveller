json.array!(@days) do |day|
  json.extract! day, :id, :trip_id, :name, :description, :cost, :image, :link
  json.url day_url(day, format: :json)
end
