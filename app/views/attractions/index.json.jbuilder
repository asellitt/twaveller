json.array!(@attractions) do |attraction|
  json.extract! attraction, :id, :area_id, :name, :description, :cost, :image, :link
  json.url attraction_url(attraction, format: :json)
end
