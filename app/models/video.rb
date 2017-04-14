class Video < ActiveRecord::Base
  ######## CALLBACKS
  before_create :set_track_id

  ######## RELATIONSHIPS
  belongs_to :user

  ######## METHODS
  def embed
    "<iframe src='https://www.youtube.com/embed/#{track_id}' frameborder='0' allowfullscreen></iframe>".html_safe
  end

  private
    # Define el Track ID del video
    # http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
    def set_track_id
      if url[/youtu\.be\/([^\?]*)/]
        track_id = $1
      else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        track_id = $5
      end
    end

end
