class Video < ActiveRecord::Base
  ######### ATTRIBUTES
  attr_accessor :api_data

  ######## CALLBACKS
  before_validation :set_video_data

  ######## VALIDATIONS
  validates :url, presence: { message: 'La URL no puede estar en blanco' }
  validates :user_id, presence: { message: 'No se ha podido asociar el video a tu usuario' }

  ######## RELATIONSHIPS
  belongs_to :user

  ######### PAGINATION
  paginates_per 4

  ######## METHODS
  # Indica si tiene descripción
  def description?
    description.present?
  end

  # Devuelve el código del video embebido
  def embed
    code = if embed_code.present?
      embed_code
    else
      set_video_info
      video_info.embed_code
    end

    code.html_safe
  end

  # Devuelve el objeto VideoInfo
  def set_video_info
    self.video_info ||=VideoInfo.new(url)
  end

  private
    attr_accessor :video_info

    # Define el Track ID del video
    # http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
    def set_video_data
      if url.present?
        set_video_info

        # Obtenemos datos del video directamente del proveedor
        self.provider = video_info.provider
        self.embed_code = video_info.embed_code(iframe_attributes: {allowfullscreen: true})
        self.video_id = video_info.video_id
        self.thumbnail = video_info.thumbnail
        self.duration = video_info.duration

        # Si se quiere seleccionar datos desde la api carga el título y la descripción desde ahí
        if api_data
          self.title = video_info.title
          self.description = video_info.description
        end
      end
    rescue VideoInfo::UrlError
      self.errors.add(:url, 'La URL proporcionada no es válida')
    rescue VideoInfo::HttpError
      self.errors.add(:video, 'No se ha podido acceder a los datos del vídeo')
    end
end
