require 'delegate'

class BandPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def band
    __getobj__
  end
end
