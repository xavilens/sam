class Song < ActiveRecord::Base
  require 'soundcloud'

  ######## RELATIONSHIPS
  belongs_to :user

  ######## METHODS
  # Devuelve el código para embeber la canción
  # ref: https://developers.soundcloud.com/docs/api/guide#playing
  def embed
    # Creamos un objeto Cliente con las credenciales de la app
    client = Soundcloud.new(:client_id => 'YOUR_CLIENT_ID')

    # Obtenemos los datos de embeber la pista
    embed_info = client.get('/oembed', url: url, show_comments: false)

    # imprime el html del widget de embebido
    puts embed_info['html']
  end
end
