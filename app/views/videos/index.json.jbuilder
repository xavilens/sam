json.array!(@videos) do |video|
  json.extract! video, :id, :name, :url, :track_id, :user_id, :in_user_page
  json.url video_url(video, format: :json)
end
