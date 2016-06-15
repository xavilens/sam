json.array!(@posts) do |post|
  json.extract! post, :id, :titulo, :user_id, :cuerpo, :publicado
  json.url post_url(post, format: :json)
end
