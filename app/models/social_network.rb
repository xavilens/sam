class SocialNetwork
  attr_reader :name, :url, :fa_icon

  def initialize (name, url, fa_icon)
    @name = name
    @url = url
    @fa_icon = fa_icon
  end

  def valid?
    !url.blank?
  end

  def to_s
    name
  end

end
