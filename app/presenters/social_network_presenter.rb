require 'delegate'

class SocialNetworkPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def icon
    fa_icon
  end

  def formatted_url
    if url_include?("http://") || url_include?("https://")
      social_network.url
    else
      "http://" + social_network.url
    end
  end

  def url_include? (string)
    social_network.url.include? string
  end

  def social_network
    __getobj__
  end
end
