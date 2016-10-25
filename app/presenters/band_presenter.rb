require 'delegate'

class BandPresenter < SimpleDelegator
  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve el objeto band original
  def band
    __getobj__
  end
end
