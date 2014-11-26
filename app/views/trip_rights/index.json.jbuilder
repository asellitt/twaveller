json.array!(@trip_rights) do |trip_right|
  json.extract! trip_right, :id, :trip_id, :user_id, :permission
  json.url trip_right_url(trip_right, format: :json)
end
