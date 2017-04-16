class Video < ActiveRecord::Base
  ######## CALLBACKS
  before_create :set_video_data
  before_update :set_video_data

  ######## VALIDATIONS
  validates :url, presence: true
  validates :user_id, presence: true
  validates :provider, presence: true
  validates :embed_code, presence: true

  ######## RELATIONSHIPS
  belongs_to :user

  ######## METHODS

  # Devuelve el código del video embebido
  def embed
    video ||= VideoInfo.new(url)

    video.embed_code.html_safe
  end

  private
    attr_accessor :video

    # Define el Track ID del video
    # http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
    def set_video_data
      @video = VideoInfo.new(url)

      self.title = video.title
      self.video_id = video.video_id
      self.thumbnail = video.thumbnail
      self.duration = video.duration
      self.provider = video.provider
    end
end
