json.array!(@areas) do |area|
  json.extract! area, :id, :trip_id, :name, :description, :cost, :image, :link
  json.url area_url(area, format: :json)
end
