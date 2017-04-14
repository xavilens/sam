json.array!(@songs) do |song|
  json.extract! song, :id, :url, :track_id, :user_id, :in_user_page
  json.url song_url(song, format: :json)
end
