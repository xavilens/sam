require 'delegate'

class MessagePresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def message
    __getobj__
  end
end
