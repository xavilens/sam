require 'delegate'

class UserPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def location
    "#{user.city}, #{user.state}"
  end

  def type
    if user.musician?
      'Músico'
    elsif user.band?
      'Grupo'
    end
  end

  def bio
    unless user.bio.blank?
      (user.bio.gsub(/\n/, '<br/>')).html_safe
    end
  end

  def avatar(version = nil)
    user.avatar_url(version)
  end

  def index_avatar
    avatar(:index_avatar_1)
  end

  def thumb_avatar
    avatar(:thumb_avatar)
  end

  def user
    __getobj__
  end
end
