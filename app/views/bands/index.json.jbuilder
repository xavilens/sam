json.array!(@bands) do |band|
  json.extract! band, :id, :genre1_id, :genre2_id, :genre3_id
  json.url band_url(band, format: :json)
end
