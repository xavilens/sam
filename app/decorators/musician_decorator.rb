require 'delegate'

class MusicianDecorator < SimpleDelegator
  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve el objeto musician original
  def musician
    __getobj__
  end
end
