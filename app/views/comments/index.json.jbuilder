json.array!(@comments) do |comment|
  json.extract! comment, :id, :post_id, :user_id, :cuerpo, :editado
  json.url comment_url(comment, format: :json)
end
