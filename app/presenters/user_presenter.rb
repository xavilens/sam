require 'delegate'

class UserPresenter < SimpleDelegator
  #
  # def initialize(user)
  #   @user = user
  # end

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

  def user
    __getobj__
  end
  # private
  #
  #   attr_reader :user
end
