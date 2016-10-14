require 'delegate'

class UserPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # USER DATA
  def type
    if user.musician?
      'Músico'
    elsif user.band?
      'Grupo'
    end
  end

  def member_header
    if user.musician?
      'Grupos'
    elsif user.band?
      'Miembros'
    end
  end

  def membership?
    if user.musician?
      !user.profile.bands.blank?
    elsif user.band?
      !user.profile.members.blank?
    end
  end

  def bio?
    !user.bio.blank?
  end

  def bio
    if bio?
      (user.bio.gsub(/\n/, '<br/>')).html_safe
    end
  end

  def location
    address = user.address

    "#{address.city} (#{address.province}), #{address.region}"
  end

  def social_networks?
    !user.social_networks_set.blank?
  end

  def social_networks
    SocialNetworkPresenter.wrap(user.social_networks_set.avaliables)
  end

  def images?
    !images.blank?
  end

  # AVATAR
  def avatar?(version = nil)
    !user.avatar_url(version).blank?
  end

  def index_avatar
    user.avatar_url(:index_avatar_1)
  end

  def index_2_avatar
    user.avatar_url(:index_avatar_2)
  end

  def thumb_avatar
    avatar(:thumb_avatar)
  end

  def thumb_s_avatar
    avatar(:thumb_avatar_s)
  end

  def avatar_s
    avatar(:avatar_s)
  end

  def user
    __getobj__
  end
end
