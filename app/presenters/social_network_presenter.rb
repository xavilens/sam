require 'delegate'

class SocialNetworkPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def icon
    fa_icon social_network.fa_icon
  end

  def social_network
    __getobj__
  end
end
