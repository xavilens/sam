require 'delegate'

class MusicianPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def musician
    __getobj__
  end
end
