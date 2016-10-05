class SocialNetwork < ActiveRecord::Base
  belongs_to :socialeable, polymorphic: true

  cattr_reader icon: {facebook: 'facebook', twitter: 'twitter', youtube: 'youtube',
    soundcloud: 'soundcloud', website: 'globe', instagram: 'instagram', gplus: 'google-plus'}

  def icon social_network
    icon[social_network]
  end
end
